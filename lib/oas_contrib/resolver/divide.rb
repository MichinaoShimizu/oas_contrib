require 'oas_contrib/resolver/base'

module OasContrib
  # Command Resolvers
  module Resolver
    # Divide command resolver
    class Divide < OasContrib::Resolver::Base
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

      private

      # Output directory and files
      # @param [Hash] hash data
      # @param [String] path directory path
      # @return [nil]
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

      # <Description>
      # @param [<Type>] dir <description>
      # @param [<Type>] hash_key <description>
      # @param [<Type>] num <description>
      # @return [<Type>] <description>
      def _output_dir_file_path_modify(dir, hash_key, num)
        prefix    = num.to_s.rjust(3, '0')
        file_name = hash_key.tr('/', '_').gsub(/^_/, '')
        dir + '/' + prefix + '_' + file_name + @outfile_ext
      end

      # <Description>
      # @param [<Type>] hash <description>
      # @param [<Type>] filter_key <description>
      # @return [<Type>] <description>
      def _output_dir_file_data_filter(hash, filter_key)
        hash.select { |key, _| key == filter_key }
      end
    end
  end
end
