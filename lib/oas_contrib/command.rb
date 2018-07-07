require 'thor'
require 'oas_contrib/resolver/divide'
require 'oas_contrib/resolver/merge'
require 'oas_contrib/resolver/preview'

module OasContrib
  class Command < Thor
    option :out_type, type: :string, default: 'yaml', desc: 'output file type (yaml or json)'
    desc 'divide <input_file> <output_dir>', 'Divide the OAS file into path units and schema units.'

    def divide(infile, outdir)
      OasContrib::Resolver::Divide.new(infile, outdir, options).run
    end

    option :in_type, type: :string, default: 'yaml', desc: 'input file type (yaml or json)'
    desc 'merge <input_dir> <output_file>', 'Merge multiple divided files into an OAS file.'

    def merge(indir, outfile)
      OasContrib::Resolver::Merge.new(indir, outfile, options).run
    end

    option :port, type: :string, default: '50010', desc: 'Swagger UI listen port'
    desc 'preview <input_file>', 'Preview OAS file using Swagger-UI official Docker image.'

    def preview(infile)
      OasContrib::Resolver::Preview.new(infile, options).run
    end
  end
end
