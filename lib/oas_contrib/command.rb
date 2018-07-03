require 'thor'
require 'oas_contrib/command_util'

module OasContrib
  # OAS contrib commands
  # @author Michinao Shimizu
  class Command < Thor
    include CommandUtil

    option :in_type,  :type => :string, :aliases => '-it', :default => 'yaml', :desc => 'input file type (yaml or json)'
    option :out_type, :type => :string, :aliases => '-ot', :default => 'yaml', :desc => 'output file type (yaml or json)'
    desc 'divide <input_file_path> <output_directory_path>', 'Divide the OAS file into path units and schema units.'

    # Divide the OAS file into path units and schema units
    # @param [String] in_file input file path
    # @param [String] out_dir output directory path
    # @return [Boolean]
    def divide(in_file, out_dir)
      raise ArgumentError, "in_file:[#{in_file}] is not exists." unless File.exist?(in_file)
      in_type  = options['in_type']
      out_type = options['out_type']
      hash = input_solo(in_file, in_type)
      version = definition_version(hash)

      meta_file = get_meta_file_path(out_dir, out_type)
      path_dir = get_path_dir_path(out_dir)
      schema_dir = get_schema_dir_path(out_dir, version)

      FileUtils.mkdir_p(path_dir)
      FileUtils.mkdir_p(schema_dir)

      output_solo(meta_filter(hash), meta_file, out_type)
      output_multi(hash['paths'], path_dir, out_type)
      output_multi(schema_filter(hash, version), schema_dir, out_type)
    end

    option :in_type,  :type => :string, :aliases => '-it', :default => 'yaml', :desc => 'input file type (yaml or json)'
    option :out_type, :type => :string, :aliases => '-ot', :default => 'yaml', :desc => 'output file type (yaml or json)'
    desc 'merge <input_directory_path> <output_file_path>', 'Merge multiple divided files into an OAS file.'

    # Merge multiple divided files into an OAS file.
    # @param [String] in_dir input directory path
    # @param [String] out_file output file path
    # @return [Boolean]
    def merge(in_dir, out_file)
      raise ArgumentError, "in_dir:[#{in_dir}] is not exists." unless File.exist?(in_dir)
      in_type  = options['in_type']
      out_type = options['out_type']

      meta_file = get_meta_file_path(in_dir, in_type)
      hash = input_solo(meta_file, in_type)
      version = definition_version(hash)

      path_dir = get_path_dir_path(in_dir)
      schema_dir = get_schema_dir_path(in_dir, version)

      hash['components'] = {}
      hash['paths'] = input_multi(path_dir, in_type)
      case version
      when 'v2' then hash['definitions'] = input_multi(schema_dir, in_type)
      when 'v3' then hash['components']['schemas'] = input_multi(schema_dir, in_type)
      end
      output_solo(hash, out_file, out_type)
    end

    option :port,  :type => :string, :aliases => '-p', :default => '50010', :desc => 'Swagger UI listen port'
    desc 'preview <input_file>', 'Preview OAS file using Swagger-UI official Docker image.'

    # Preview OAS file using Swagger-UI official Docker image.
    # @param [String] in_file input file path
    # @return [Boolean] return code
    def preview(in_file)
      raise ArgumentError, "in_file:[#{in_file}] is not exists." unless File.exist?(in_file)
      port = options['port']
      path = File.expand_path(in_file)
      basename = File.basename(path)
      puts "SwaggerUI listen: http://localhost:#{port} with: #{in_file}"
      Kernel.exec "docker run --rm --name oas_contrib_preview_swagger_ui \
      -p #{port}:8080 -e API_URL=#{basename} \
      -v #{path}:/usr/share/nginx/html/#{basename} swaggerapi/swagger-ui"
    end
  end
end
