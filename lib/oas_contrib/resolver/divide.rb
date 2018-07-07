require 'oas_contrib/resolver/base'

module OasContrib
  # Command Resolvers
  module Resolver
    # Divide command resolver
    class Divide < OasContrib::Resolver::Base
      # Initialize
      # @param [String] infile input file path
      # @param [String] outdir output directory path
      # @param [String] type output file type (json or yaml)
      def initialize(infile, outdir, type)
        @meta_dir     = outdir + '/meta'
        @path_dir     = outdir + '/path'
        @model_dir    = outdir + '/model'
        @infile       = infile
        @outfile_type = type
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
