require 'oas_contrib/resolver/base'

module OasContrib
  module Resolver
    class Merge < OasContrib::Resolver::Base
      def initialize(indir, outfile, options)
        @meta_dir   = indir + '/meta'
        @path_dir   = indir + '/path'
        @model_dir  = indir + '/model'
        @outfile    = outfile
        @infile_ext = options['in_ext']
      end

      def setup
        @outfile_ext = File.extname(@outfile)
        file_ext_check
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
