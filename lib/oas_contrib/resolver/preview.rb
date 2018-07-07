require 'oas_contrib/resolver/base'

module OasContrib
  # Command Resolvers
  module Resolver
    # Preview command resolver
    class Preview < Resolver::Base
      # Initialize
      # @param [String] input_file_path input file path
      # @param [String] input_file_type input file type (json or yaml)
      def initialize(input_file_path, port)
        @input_file_path = input_file_path
        @port = port
      end

      # Run
      # @return [nil]
      def run
        load
        dist
      end

      # Load
      # @return [nil]
      def load
        @expand_path = File.expand_path(@input_file_path)
        @basename = File.basename(@expand_path)
        nil
      end

      # Distribute
      # @return [nil]
      def dist
        puts "SwaggerUI listen: http://localhost:#{@port} with: #{@expand_path}"
        `docker run --rm --name oas_contrib_preview_swagger_ui \
        -p #{@port}:8080 -e API_URL=#{@basename} \
        -v #{@expand_path}:/usr/share/nginx/html/#{@basename} swaggerapi/swagger-ui`
        raise 'Preview command needs docker.' unless $?.exitstatus.zero?
      end
    end
  end
end
