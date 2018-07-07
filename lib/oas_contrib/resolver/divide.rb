require 'oas_contrib/resolver/base'

module OasContrib
  # Command Resolvers
  module Resolver
    # Divide command resolver
    class Divide < OasContrib::Resolver::Base
      # @!attribute [r] meta_dir
      #   @return [<Type>] <description>
      attr_reader :meta_dir
      # @!attribute [r] path_dir
      #   @return [<Type>] <description>
      attr_reader :path_dir
      # @!attribute [r] model_dir
      #   @return [<Type>] <description>
      attr_reader :model_dir
      # @!attribute [r] infile
      #   @return [<Type>] <description>
      attr_reader :infile
      # @!attribute [r] infile_ext
      #   @return [<Type>] <description>
      attr_reader :infile_ext
      # @!attribute [r] outfile_type
      #   @return [<Type>] <description>
      attr_reader :outfile_type
      # @!attribute [r] outfile_ext
      #   @return [<Type>] <description>
      attr_reader :outfile_ext

      # Initialize
      # @param [String] infile input file path
      # @param [String] outdir output directory path
      # @param [Array] options options
      def initialize(infile, outdir, options)
        @meta_dir     = outdir + '/meta'
        @path_dir     = outdir + '/path'
        @model_dir    = outdir + '/model'
        @infile       = infile
        @outfile_type = options['out_type']
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
        @infile_ext  = File.extname(@infile)
        @outfile_ext = str2ext(@outfile_type)
      end

      # Load the OAS file
      # @return [Hash] loaded data
      def load
        input(@infile)
      end

      # Output divided files
      # @return [nil]
      def dist
        output_dir(@spec.meta,  @meta_dir)
        output_dir(@spec.path,  @path_dir)
        output_dir(@spec.model, @model_dir)
      end
    end
  end
end
