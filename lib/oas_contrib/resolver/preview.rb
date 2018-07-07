require 'oas_contrib/resolver/base'

module OasContrib
  module Resolver
    class Preview < OasContrib::Resolver::Base
      def initialize(infile, options)
        @infile = infile
        @port = options['port']
      end

      def setup
        @expand_path = File.expand_path(@infile)
        @basename = File.basename(@expand_path)
      end

      def distribute
        puts "SwaggerUI listen: http://localhost:#{@port} with: #{@expand_path}"
        `docker run --rm --name oas_contrib_preview_swagger_ui \
        -p #{@port}:8080 -e API_URL=#{@basename} \
        -v #{@expand_path}:/usr/share/nginx/html/#{@basename} swaggerapi/swagger-ui`
        raise 'Preview command needs docker.' unless $?.exitstatus.zero?
      end
    end
  end
end
