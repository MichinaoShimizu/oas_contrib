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

      def run
        setup
        load
        resolve
        dist
      end

      def setup
        @infile_ext  = str2ext(@infile_type)
        @outfile_ext = File.extname(@outfile)
      end

      def load
        _load_meta
        resolve
        _load_path
        _load_model
      end

      def dist
        output(@data, @outfile)
      end

      private

      def _load_meta
        @data = _input_dir(@meta_dir)
      end

      def _load_path
        @data['paths'] = _input_dir(@path_dir)
      end

      def _load_model
        @data['definitions'] = _input_dir(@model_dir) if v2?
        @data['components'] = { 'schemas' => _input_dir(@model_dir) } if v3?
      end

      def _input_dir(dir)
        path = dir + '/**/*' + @infile_ext
        Dir.glob(path).sort.each_with_object({}, &_input_lambda)
      end

      def _input_lambda
        lambda do |file, result|
          hash = _input(file)
          key = hash.keys[0]
          result[key] = hash[key]
        end
      end
    end
  end
end
