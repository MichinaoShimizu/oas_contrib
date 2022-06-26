require 'oas_contrib/interface/resolver'
require 'oas_contrib/openapi/v2/spec'
require 'oas_contrib/openapi/v3/spec'
require 'yaml'
require 'json'

module OasContrib
  module Resolver
    # Basical command resolver class
    class Base
      # @!attribute [r] data
      #   @return [Hash] parsed input data hash
      attr_reader :data

      # @!attribute [r] spec
      #   @return [OpenAPI::V3::Spec|OpenAPI::V2::Spec] mapped spec data object
      attr_reader :spec

      include OasContrib::Interface::Resolver

      # @return [Array] approval file extensions
      DEFINED_FILE_EXT = ['.json', '.yml', '.yaml'].freeze

      # @return [String] the directory name of meta part files
      DIR_NAME_META = 'meta'.freeze

      # @return [String] the directory name of path part files
      DIR_NAME_PATH = 'path'.freeze

      # @return [String] the directory name of model part files
      DIR_NAME_MODEL = 'model'.freeze

      # Check the file extensions is approved or not.
      # @return [Boolean]
      def file_ext_check
        if @infile_ext && !DEFINED_FILE_EXT.include?(@infile_ext)
          raise "Undefined input file extension. #{@infile_ext}"
        end

        if @outfile_ext && !DEFINED_FILE_EXT.include?(@outfile_ext)
          raise "Undefined output file extension. #{@outfile_ext}"
        end
        true
      end

      # Check the format of input file is OpenAPI v3 specificaion or not.
      # @return [Boolean]
      def v3?
        @data['openapi'] =~ /^3/
      end

      # Check the format of input file is OpenAPI v2 specificaion or not.
      # @return [Boolean]
      def v2?
        @data['swagger'] =~ /^2/
      end

      # Judge and generate OpenAPI specification object.
      # @return [OpenAPI::V3::Spec|OpenAPI::V2::Spec] mapped spec data object
      def resolve
        @spec = OasContrib::OpenAPI::V2::Spec.new(@data) if v2?
        @spec = OasContrib::OpenAPI::V3::Spec.new(@data) if v3?
        raise 'Undefined OAS file.' unless @spec
        @spec.mapping
      end

      # Load and parse the input file.
      # @param [String] path input file path
      # @return [Hash] parsed input data hash
      def input(path)
        @data = _input(path)
      end

      # Output a new file with mapped spec data hash.
      # @param [Hash] hash mapped spec data hash
      # @param [String] path output file path
      # @return [IO]
      def output(hash, path)
        File.open(path, 'w') { |f| _output(hash, f) }
      end

      # Load and parse the files in target directory recursive.
      # @param [String] dir input directory path
      # @return [Hash] parsed input data hash
      def input_dir(dir)
        path = dir + '/**/*' + @infile_ext
        Dir.glob(path).sort.each_with_object({}, &input_lambda)
      end

      # Load and parse the file proc.
      # @return [Proc]
      def input_lambda
        lambda do |file, result|
          hash = _input(file)
          key = hash.keys[0]
          result[key] = hash[key]
        end
      end

      private

      # Load and prase the file depending on the file extension.
      # @param [String] path input file path
      # @return [Hash] parsed input data hash
      def _input(path)
        puts "Load: #{path}"
        case @infile_ext
        when DEFINED_FILE_EXT[0] then JSON.parse(File.read(path))
        when DEFINED_FILE_EXT[1] then YAML.load_file(path)
        when DEFINED_FILE_EXT[2] then YAML.load_file(path)
        else raise ArgumentError, 'Undefined input file type'
        end
      end

      # Write the spec data hash depending on the file extension.
      # @param [Hash] hash mapped spec data hash
      # @param [String] file output file path
      # @return [IO]
      def _output(hash, file)
        puts "Dist: #{file.path}"
        p @outfile_ext
        case @outfile_ext
        when DEFINED_FILE_EXT[0] then JSON.dump(hash, file)
        when DEFINED_FILE_EXT[1] then YAML.dump(hash, file)
        when DEFINED_FILE_EXT[2] then YAML.dump(hash, file)
        else raise ArgumentError, 'Undefined output file type'
        end
      end
    end
  end
end
