require 'thor'
require 'oas_contrib/command_resolvers/divide'
require 'oas_contrib/command_resolvers/merge'

module OasContrib
  # Commands
  class Command < Thor
    option :out_type, type: :string, aliases: '-ot', default: 'yaml', desc: 'output file type (yaml or json)'
    desc 'divide <input_file> <output_dir>', 'Divide the OAS file into path units and schema units.'

    # Command (Divide the OAS file into path units and schema units)
    # @param [String] in_file input file path
    # @param [String] out_dir output directory path
    # @return [Integer]
    def divide(in_file, out_dir)
      CommandResolvers::Divide.new(in_file, out_dir, options['out_type']).run
    end

    option :in_type, type: :string, aliases: '-it', default: 'yaml', desc: 'input file type (yaml or json)'
    desc 'merge <input_dir> <output_file>', 'Merge multiple divided files into an OAS file.'

    # Command (Merge multiple divided files into an OAS file)
    # @param [String] in_dir input directory path
    # @param [String] out_file output file path
    # @return [Integer]
    def merge(in_dir, out_file)
      CommandResolvers::Merge.new(in_dir, out_file, options['in_type']).run
    end

    option :port, type: :string, aliases: '-p', default: '50010', desc: 'Swagger UI listen port'
    desc 'preview <input_file>', 'Preview OAS file using Swagger-UI official Docker image.'

    # Preview OAS file using Swagger-UI official Docker image.
    # @param [String] in_file input file path
    # @return [Integer]
    def preview(in_file)
      port = options['port']
      path = File.expand_path(in_file)
      basename = File.basename(path)
      puts "SwaggerUI listen: http://localhost:#{port} with: #{in_file}"
      `docker run --rm --name oas_contrib_preview_swagger_ui \
      -p #{port}:8080 -e API_URL=#{basename} \
      -v #{path}:/usr/share/nginx/html/#{basename} swaggerapi/swagger-ui`
      raise 'Preview command needs docker.' unless $?.exitstatus.zero?
    end
  end
end
