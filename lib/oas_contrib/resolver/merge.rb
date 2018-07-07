require 'oas_contrib/resolver/base'

module OasContrib
  # Command Resolvers
  module Resolver
    # Merge command resolver
    class Merge < OasContrib::Resolver::Base
      # Initialize
      # @param [String] indir input directory path
      # @param [String] outfile output file path
      # @param [Array] options options
      def initialize(indir, outfile, options)
        @meta_dir    = indir + '/meta'
        @path_dir    = indir + '/path'
        @model_dir   = indir + '/model'
        @outfile     = outfile
        @infile_type = options['in_type']
      end

      # Run
      # @return [nil]
      def run
        setup
        load
        resolve
        dist
      end

      # <Description>
      # @return [<Type>] <description>
      def setup
        @infile_ext  = str2ext(@infile_type)
        @outfile_ext = File.extname(@outfile)
      end

      # Load divided files
      # @return [Hash] load and merged data
      def load
        load_meta
        resolve
        load_path
        load_model
      end

      # Output the OAS file
      # @return [nil]
      def dist
        output(@data, @outfile)
      end

      private

      # Load meta part files
      # @return [Hash] loaded data
      def load_meta
        @data = input_dir(@meta_dir)
      end

      # Load path part files
      # @return [Hash] load and merged data
      def load_path
        @data['paths'] = input_dir(@path_dir)
      end

      # Load model part files
      # @return [Hash] load and merged data
      def load_model
        @data['definitions'] = input_dir(@model_dir) if v2?
        @data['components'] = { 'schemas' => input_dir(@model_dir) } if v3?
      end

      # Load directory files
      # @param [String] path input directory
      # @return [Hash] merged input files data
      def input_dir(dir)
        path = dir + '/**/*' + @infile_ext
        Dir.glob(path).sort.each_with_object({}, &input_lambda)
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
    end
  end
end
