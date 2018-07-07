require 'oas_contrib/interface/resolver'
require 'oas_contrib/openapi/v2/spec'
require 'oas_contrib/openapi/v3/spec'
require 'yaml'
require 'json'

module OasContrib
  module Resolver
    # CommandResolver Base
    class Base
      # @!attribute [r] data
      #   @return [<Type>] <description>
      attr_reader :data

      # @!attribute [r] spec
      #   @return [<Type>] <description>
      attr_reader :spec

      include OasContrib::Interface::Resolver

      # <Description>
      # @return [<Type>] <description>
      def v3?
        @data['openapi'] =~ /^3/
      end

      # <Description>
      # @return [<Type>] <description>
      def v2?
        @data['swagger'] =~ /^2/
      end

      # Resolver spec object
      # @raise [StandardError]
      # @return [OasContrib::Swagger::V2::Spec|OasContrib::OpenAPI::V3::Spec] spec
      def resolve
        @spec = OasContrib::OpenAPI::V2::Spec.new(@data) if v2?
        @spec = OasContrib::OpenAPI::V3::Spec.new(@data) if v3?
        raise 'Undefined OAS file.' unless @spec
        @spec.mapping
      end

      # Load a file
      # @param [String] path input file path
      # @return [Hash]
      def input(path)
        @data = _input(path)
      end

      # Output a file
      # @param [Hash] hash data
      # @param [String] path output file path
      # @return [File]
      def output(hash, path)
        File.open(path, 'w') { |f| _output(hash, f) }
      end

      # Convert file type string to file extention string.
      # @param [String] type file type string (yaml or json)
      # @raise [ArgumentError] invalid file type string
      # @return [String] file extension string (.yml or .json)
      def str2ext(type)
        case type
        when 'yaml' then '.yml'
        when 'json' then '.json'
        else raise ArgumentError, 'Undefined file type'
        end
      end

      private

      # Load a file depending on file extension
      # @param [String] path file path
      # @raise [ArgumentError] invalid file type string
      # @return [Hash]
      def _input(path)
        puts "Load: #{path}"
        case @infile_ext
        when '.yml'  then YAML.load_file(path)
        when '.json' then JSON.parse(File.read(path))
        else raise ArgumentError, 'Undefined input file type'
        end
      end

      # <Description>
      # @param [Hash] hash data
      # @param [File] file output file object
      # @raise [ArgumentError] invalid file type string
      # @return [IO]
      def _output(hash, file)
        puts "Dist: #{file.path}"
        case @outfile_ext
        when '.yml'  then YAML.dump(hash, file)
        when '.json' then JSON.dump(hash, file)
        else raise ArgumentError, 'Undefined output file type'
        end
      end
    end
  end
end
