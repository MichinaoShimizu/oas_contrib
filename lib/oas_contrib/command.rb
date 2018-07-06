require 'thor'
# require 'oas_contrib/command_util'
require 'oas_contrib/divide_command_resolver'
require 'oas_contrib/merge_command_resolver'

module OasContrib
  # OAS contrib commands
  # @author Michinao Shimizu
  class Command < Thor
    option :out_type, type: :string, aliases: '-ot', default: 'yaml', desc: 'output file type (yaml or json)'
    desc 'divide <input_file_path> <output_directory_path>', 'Divide the OAS file into path units and schema units.'
    def divide(in_file, out_dir)
      resolver = OasContrib::DivideCommandResolver.new(in_file, out_dir, options['out_type'])
      resolver.load
      resolver.resolve
      resolver.dist
    end

    option :in_type, type: :string, aliases: '-it', default: 'yaml', desc: 'input file type (yaml or json)'
    desc 'merge <input_directory_path> <output_file_path>', 'Merge multiple divided files into an OAS file.'
    def merge(in_dir, out_file)
      resolver = OasContrib::MergeCommandResolver.new(in_dir, out_file, options['in_type'])
      resolver.load
      resolver.resolve
      resolver.dist
    end

    option :port, type: :string, aliases: '-p', default: '50010', desc: 'Swagger UI listen port'
    desc 'preview <input_file>', 'Preview OAS file using Swagger-UI official Docker image.'
    def preview(in_file)
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
