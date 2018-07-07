require 'oas_contrib/resolver/base'

module OasContrib
  # Command Resolvers
  module Resolver
    # Merge command resolver
    class Merge < Resolver::Base
      # Initialize
      # @param [String] indir input directory path
      # @param [String] outfile output file path
      # @param [String] type input file type (json or yaml)
      def initialize(indir, outfile, type)
        @meta_dir    = indir + '/meta'
        @path_dir    = indir + '/path'
        @model_dir   = indir + '/model'
        @outfile     = outfile
        @infile_type = type
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
        @data = input_dir(@meta_dir + '/**/*' + @infile_ext)
      end

      # Load path part files
      # @return [Hash] load and merged data
      def load_path
        @data['paths'] = input_dir(@path_dir + '/**/*' + @infile_ext)
      end

      # Load model part files
      # @return [Hash] load and merged data
      def load_model
        path = @model_dir + '/**/*' + @infile_ext
        if v3?
          @data['components'] = {}
          @data['components']['schemas'] = input_dir(path)
        end
        if v2?
          @data['definitions'] = input_dir(path)
        end
      end
    end
  end
end
