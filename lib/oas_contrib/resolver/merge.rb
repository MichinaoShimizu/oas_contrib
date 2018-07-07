require 'oas_contrib/resolver/base'

module OasContrib
  module Resolver
    class Merge < OasContrib::Resolver::Base
      def initialize(indir, outfile, options)
        @meta_dir    = indir + '/meta'
        @path_dir    = indir + '/path'
        @model_dir   = indir + '/model'
        @outfile     = outfile
        @infile_type = options['in_type']
      end

      def setup
        @infile_ext  = str2ext(@infile_type)
        @outfile_ext = File.extname(@outfile)
      end

      def load
        @data = input_dir(@meta_dir)
        resolve
        @data['paths'] = input_dir(@path_dir)
        @data['definitions'] = input_dir(@model_dir) if v2?
        @data['components'] = { 'schemas' => input_dir(@model_dir) } if v3?
      end

      def distribute
        output(@data, @outfile)
      end
    end
  end
end
