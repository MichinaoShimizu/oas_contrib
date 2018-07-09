require 'oas_contrib/resolver/base'

module OasContrib
  module Resolver
    # Preview command resolver class
    class Preview < OasContrib::Resolver::Base
      # Initialize
      # @param [String] infile spec file path
      # @param [Array] options command options
      def initialize(infile, options)
        @infile = infile
        @port = options['port']
      end

      # Setup the resolver object.
      # @return [Boolean]
      def setup
        @expand_path = File.expand_path(@infile)
        @basename    = File.basename(@expand_path)
        @infile_ext  = File.extname(@infile)
        file_ext_check
        true
      end

      # Distribute the command artifacts.
      # @return [Boolean]
      def distribute
        puts "SwaggerUI listen: http://localhost:#{@port} with: #{@expand_path}"
        `docker run --rm --name oas_contrib_preview_swagger_ui \
        -p #{@port}:8080 -e API_URL=#{@basename} \
        -v #{@expand_path}:/usr/share/nginx/html/#{@basename} swaggerapi/swagger-ui`
        raise 'Preview command needs docker.' unless $?.exitstatus.zero?
        true
      end
    end
  end
end
