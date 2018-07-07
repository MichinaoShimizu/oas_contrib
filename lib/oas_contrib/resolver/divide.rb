require 'oas_contrib/resolver/base'

module OasContrib
  module Resolver
    class Divide < OasContrib::Resolver::Base
      def initialize(infile, outdir, options)
        @meta_dir     = outdir + '/meta'
        @path_dir     = outdir + '/path'
        @model_dir    = outdir + '/model'
        @infile       = infile
        @outfile_type = options['out_type']
      end

      def setup
        @infile_ext  = File.extname(@infile)
        @outfile_ext = str2ext(@outfile_type)
      end

      def load
        input(@infile)
      end

      def distribute
        output_dir(@spec.meta,  @meta_dir)
        output_dir(@spec.path,  @path_dir)
        output_dir(@spec.model, @model_dir)
      end

      private

      def output_dir(hash, path)
        puts "Dist: #{path}"
        FileUtils.mkdir_p(path)
        hash.each.with_index(1) do |(k, _v), i|
          outfile_path = _output_dir_file_path_modify(path, k, i)
          outfile_data = _output_dir_file_data_filter(hash, k)
          output(outfile_data, outfile_path)
        end
        nil
      end

      def _output_dir_file_path_modify(dir, hash_key, num)
        prefix    = num.to_s.rjust(3, '0')
        file_name = hash_key.tr('/', '_').gsub(/^_/, '')
        dir + '/' + prefix + '_' + file_name + @outfile_ext
      end

      def _output_dir_file_data_filter(hash, filter_key)
        hash.select { |key, _| key == filter_key }
      end
    end
  end
end
