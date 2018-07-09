require 'oas_contrib/resolver/base'

module OasContrib
  module Resolver
    # Merge command resolver class
    class Merge < OasContrib::Resolver::Base
      # Initialize
      # @param [String] indir input directory path
      # @param [String] outfile output spec file path
      # @param [Array] options command options
      def initialize(indir, outfile, options)
        @meta_dir   = indir + '/meta'
        @path_dir   = indir + '/path'
        @model_dir  = indir + '/model'
        @outfile    = outfile
        @infile_ext = options['in_ext']
      end

      # Setup the resolver object.
      # @return [Boolean]
      def setup
        @outfile_ext = File.extname(@outfile)
        file_ext_check
        true
      end

      # Load and parse the input files.
      # @return [Boolean]
      def load
        @data = input_dir(@meta_dir)
        resolve
        @data['paths'] = input_dir(@path_dir)
        @data['definitions'] = input_dir(@model_dir) if v2?
        @data['components'] = { 'schemas' => input_dir(@model_dir) } if v3?
        true
      end

      # Distribute the command artifacts.
      # @return [Boolean]
      def distribute
        output(@data, @outfile)
        true
      end
    end
  end
end
