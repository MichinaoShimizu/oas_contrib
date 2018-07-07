require 'thor'
require 'oas_contrib/resolver/divide'
require 'oas_contrib/resolver/merge'
require 'oas_contrib/resolver/preview'

module OasContrib
  # Commands
  class Command < Thor
    option :out_type, type: :string, default: 'yaml', desc: 'output file type (yaml or json)'
    desc 'divide <input_file> <output_dir>', 'Divide the OAS file into path units and schema units.'
    # Command (Divide the OAS file into path units and schema units)
    # @param [String] infile input file path
    # @param [String] outdir output directory path
    # @return [Integer]
    def divide(infile, outdir)
      OasContrib::Resolver::Divide.new(infile, outdir, options['out_type']).run
    end

    option :in_type, type: :string, default: 'yaml', desc: 'input file type (yaml or json)'
    desc 'merge <input_dir> <output_file>', 'Merge multiple divided files into an OAS file.'
    # Command (Merge multiple divided files into an OAS file)
    # @param [String] indir input directory path
    # @param [String] outfile output file path
    # @return [Integer]
    def merge(indir, outfile)
      OasContrib::Resolver::Merge.new(indir, outfile, options['in_type']).run
    end

    option :port, type: :string,default: '50010', desc: 'Swagger UI listen port'
    desc 'preview <input_file>', 'Preview OAS file using Swagger-UI official Docker image.'
    # Preview OAS file using Swagger-UI official Docker image.
    # @param [String] infile input file path
    # @return [Integer]
    def preview(infile)
      OasContrib::Resolver::Preview.new(infile, options['port']).run
    end
  end
end
