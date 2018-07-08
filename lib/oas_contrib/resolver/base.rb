require 'oas_contrib/interface/resolver'
require 'oas_contrib/openapi/v2/spec'
require 'oas_contrib/openapi/v3/spec'
require 'yaml'
require 'json'

module OasContrib
  module Resolver
    class Base
      attr_reader :data, :spec

      include OasContrib::Interface::Resolver

      DEFINED_FILE_EXT = ['.json', '.yml'].freeze

      def file_ext_check
        if @infile_ext && !DEFINED_FILE_EXT.include?(@infile_ext)
          raise "Undefined input file extension. #{@infile_ext}"
        end

        if @outfile_ext && !DEFINED_FILE_EXT.include?(@outfile_ext)
          raise "Undefined output file extension. #{@outfile_ext}"
        end
      end

      def v3?
        @data['openapi'] =~ /^3/
      end

      def v2?
        @data['swagger'] =~ /^2/
      end

      def resolve
        @spec = OasContrib::OpenAPI::V2::Spec.new(@data) if v2?
        @spec = OasContrib::OpenAPI::V3::Spec.new(@data) if v3?
        raise 'Undefined OAS file.' unless @spec
        @spec.mapping
      end

      def input(path)
        @data = _input(path)
      end

      def output(hash, path)
        File.open(path, 'w') { |f| _output(hash, f) }
      end

      def input_dir(dir)
        path = dir + '/**/*' + @infile_ext
        Dir.glob(path).sort.each_with_object({}, &input_lambda)
      end

      def input_lambda
        lambda do |file, result|
          hash = _input(file)
          key = hash.keys[0]
          result[key] = hash[key]
        end
      end

      private

      def _input(path)
        puts "Load: #{path}"
        case @infile_ext
        when '.yml'  then YAML.load_file(path)
        when '.json' then JSON.parse(File.read(path))
        else raise ArgumentError, 'Undefined input file type'
        end
      end

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
