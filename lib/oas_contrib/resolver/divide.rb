require 'oas_contrib/resolver/base'

module OasContrib
  module Resolver
    # Divide command resolver class
    class Divide < OasContrib::Resolver::Base
      # Initialize
      # @param [String] infile spec file path
      # @param [String] outdir output directory path
      # @param [Array] options command options
      def initialize(infile, outdir, options)
        @meta_dir     = outdir + '/' + DIR_NAME_META
        @path_dir     = outdir + '/' + DIR_NAME_PATH
        @model_dir    = outdir + '/' + DIR_NAME_MODEL
        @infile       = infile
        @outfile_ext  = options['out_ext']
      end

      # Setup the resolver object.
      # @return [Boolean]
      def setup
        @infile_ext = File.extname(@infile)
        file_ext_check
        true
      end

      # Load and parse the input file.
      # @return [Boolean]
      def load
        input(@infile)
        true
      end

      # Distribute the command artifacts.
      # @return [Boolean]
      def distribute
        output_dir(@spec.meta,  @meta_dir)
        output_dir(@spec.path,  @path_dir)
        output_dir(@spec.model, @model_dir)
        true
      end

      private

      # Generate directory and output files.
      # @param [Hash] hash mapped spec data hash
      # @param [String] path output directory path
      # @return [Boolean]
      def output_dir(hash, path)
        puts "Dist: #{path}"
        FileUtils.mkdir_p(path)
        hash.each.with_index(1) do |(k, _v), i|
          outfile_path = _output_dir_file_path_modify(path, k, i)
          outfile_data = _output_dir_file_data_filter(hash, k)
          output(outfile_data, outfile_path)
        end
        true
      end

      # Modify the output file path.
      # @param [String] dir output directory path
      # @param [String] hash_key hash key
      # @param [Integer] num count of file
      # @return [String] modified file path
      def _output_dir_file_path_modify(dir, hash_key, num)
        prefix    = num.to_s.rjust(3, '0')
        file_name = hash_key.tr('/', '_').gsub(/^_/, '')
        dir + '/' + prefix + '_' + file_name + @outfile_ext
      end

      # Filter the output file data.
      # @param [Hash] hash mapped spec data hash
      # @param [String] filter_key filtering hash key
      # @return [Hash] filterd hash
      def _output_dir_file_data_filter(hash, filter_key)
        hash.select { |key, _| key == filter_key }
      end
    end
  end
end
