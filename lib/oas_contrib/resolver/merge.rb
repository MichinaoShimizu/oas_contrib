require 'oas_contrib/resolver/base'

module OasContrib
  # Command Resolvers
  module Resolver
    # Merge command resolver
    class Merge < OasContrib::Resolver::Base
      # @!attribute [r] meta_dir
      #   @return [<Type>] <description>
      attr_reader :meta_dir
      # @!attribute [r] path_dir
      #   @return [<Type>] <description>
      attr_reader :path_dir
      # @!attribute [r] model_dir
      #   @return [<Type>] <description>
      attr_reader :model_dir
      # @!attribute [r] outfile
      #   @return [<Type>] <description>
      attr_reader :outfile
      # @!attribute [r] outfile_ext
      #   @return [<Type>] <description>
      attr_reader :outfile_ext
      # @!attribute [r] infile_ext
      #   @return [<Type>] <description>
      attr_reader :infile_ext
      # @!attribute [r] infile_type
      #   @return [<Type>] <description>
      attr_reader :infile_type

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
    end
  end
end
