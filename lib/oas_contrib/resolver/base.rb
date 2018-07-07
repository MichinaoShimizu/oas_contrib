require 'oas_contrib/openapi/v2/spec'
require 'oas_contrib/openapi/v3/spec'
require 'yaml'
require 'json'

module OasContrib
  module Resolver
    # CommandResolver Base
    class Base
      # Initialze
      # @param [String] path input or output directory path
      def initialize(path)
        @meta_dir  = path + '/meta'
        @path_dir  = path + '/path'
        @model_dir = path + '/model'
      end

      # Run
      # @raise [NotImplementedError]
      # @return [nil]
      def run
        raise NotImplementedError, 'This class must be implemented "run" method.'
      end

      # Load
      # @raise [NotImplementedError]
      # @return [nil]
      def load
        raise NotImplementedError, 'This class must be implemented "load" method.'
      end

      # Distribute
      # @raise [NotImplementedError]
      # @return [nil]
      def dist
        raise NotImplementedError, 'This class must be implemented "dist" method.'
      end

      # Determine which type of definition data.
      # @raise [StandardError]
      # @return [OasContrib::Swagger::V2::Spec|OasContrib::OpenAPI::V3::Spec] spec
      def resolve
        return @spec = OasContrib::OpenAPI::V2::Spec.new(@load_data) if has_v2_meta?
        return @spec = OasContrib::OpenAPI::V3::Spec.new(@load_data) if has_v3_meta?
        raise 'Undefined OAS file.'
      end

      # <Description>
      # @return [<Type>] <description>
      def has_v3_meta?
        @load_data['openapi'] =~ /^3/
      end

      # <Description>
      # @return [<Type>] <description>
      def has_v2_meta?
        @load_data['swagger'] =~ /^2/
      end

      # Check the type of OpenAPI v3 definition or not
      # @return [Boolean]
      def v3_spec?
        @spec.is_a?(OasContrib::OpenAPI::V3::Spec)
      end

      # Check the type of OpenAPI v2 definition or not
      # @return [Boolean]
      def v2_spec?
        @spec.is_a?(OasContrib::OpenAPI::V2::Spec)
      end

      # Convert file type string to file extention string.
      # @param [String] type file type string (yaml or json)
      # @raise [ArgumentError] invalid file type string
      # @return [String] file extension string (.yml or .json)
      def file_type_to_ext(type)
        case type
        when 'yaml' then '.yml'
        when 'json' then '.json'
        else raise ArgumentError, 'Undefined file type'
        end
      end

      # Load a file
      # @param [String] path input file path
      # @return [Hash]
      def input(path)
        @load_data = input_call(path)
      end

      # Output a file
      # @param [Hash] hash data
      # @param [String] path output file path
      # @return [File]
      def output(hash, path)
        File.open(path, 'w') { |f| output_call(hash, f) }
      end

      # Load directory files
      # @param [String] path input directory
      # @return [Hash] merged input files data
      def input_dir(path)
        Dir.glob(path).sort.each_with_object({}, &input_call_lambda)
      end

      # Proc of input a yaml or json file
      # @return [Proc]
      def input_call_lambda
        lambda do |file, result|
          hash = input_call(file)
          key = hash.keys[0]
          result[key] = hash[key]
        end
      end

      # Load a file depending on file extension
      # @param [String] path file path
      # @raise [ArgumentError] invalid file type string
      # @return [Hash]
      def input_call(path)
        puts "Load: #{path}"
        case @input_file_ext
        when '.yml'  then YAML.load_file(path)
        when '.json' then JSON.parse(File.read(path))
        else raise ArgumentError, 'Undefined file type'
        end
      end

      # Output a file depending on file extension
      # @param [String] path file path
      # @raise [ArgumentError] invalid file type string
      # @return [IO]
      def output_call(hash, file)
        puts "Dist: #{file.path}"
        case @output_file_ext
        when '.yml'  then YAML.dump(hash, file)
        when '.json' then JSON.dump(hash, file)
        else raise ArgumentError, 'Undefined file type'
        end
      end

      # Output directory and files
      # @param [Hash] hash data
      # @param [String] path directory path
      # @return [nil]
      def output_dir(hash, path)
        puts "Dist: #{path}"
        FileUtils.mkdir_p(path)

        i = 1
        hash.each do |k, _v|
          key = k.tr('/', '_').gsub(/^_/, '')
          val = hash.select { |hash_key, _| hash_key == k }
          output(val, "#{path}/#{i.to_s.rjust(3, '0')}_#{key}#{@output_file_ext}")
          i += 1
        end
        nil
      end
    end
  end
end
