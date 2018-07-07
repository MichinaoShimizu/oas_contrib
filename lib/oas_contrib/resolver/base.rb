require 'oas_contrib/openapi/v2/spec'
require 'oas_contrib/openapi/v3/spec'
require 'yaml'
require 'json'

module OasContrib
  module Resolver
    # CommandResolver Base
    class Base
      # Run
      # @raise [NotImplementedError]
      # @return [nil]
      def run
        raise NotImplementedError, 'This class must be implemented "run" method.'
      end

      # Run
      # @raise [NotImplementedError]
      # @return [nil]
      def setup
        raise NotImplementedError, 'This class must be implemented "setup" method.'
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
        @spec = OasContrib::OpenAPI::V2::Spec.new(@data) if v2?
        @spec = OasContrib::OpenAPI::V3::Spec.new(@data) if v3?
        raise 'Undefined OAS file.' unless @spec
        @spec.mapping
      end

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

      # Proc of input a yaml or json file
      # @return [Proc]
      def input_lambda
        lambda do |file, result|
          hash = _input(file)
          key = hash.keys[0]
          result[key] = hash[key]
        end
      end

      # Load directory files
      # @param [String] path input directory
      # @return [Hash] merged input files data
      def input_dir(path)
        Dir.glob(path).sort.each_with_object({}, &input_lambda)
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
          output(val, "#{path}/#{i.to_s.rjust(3, '0')}_#{key}#{@outfile_ext}")
          i += 1
        end
        nil
      end

      # Load a file depending on file extension
      # @param [String] path file path
      # @raise [ArgumentError] invalid file type string
      # @return [Hash]
      def _input(path)
        puts "Load: #{path}"
        case @infile_ext
        when '.yml'  then YAML.load_file(path)
        when '.json' then JSON.parse(File.read(path))
        else raise ArgumentError, 'Undefined file type'
        end
      end

      # Output a file depending on file extension
      # @param [String] path file path
      # @raise [ArgumentError] invalid file type string
      # @return [IO]
      def _output(hash, file)
        puts "Dist: #{file.path}"
        case @outfile_ext
        when '.yml'  then YAML.dump(hash, file)
        when '.json' then JSON.dump(hash, file)
        else raise ArgumentError, 'Undefined file type'
        end
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
    end
  end
end
