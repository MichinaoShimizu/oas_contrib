require 'thor'
require 'oas_contrib/resolver/divide'
require 'oas_contrib/resolver/merge'
require 'oas_contrib/resolver/preview'

module OasContrib
  class Command < Thor
    option :out_type, type: :string, default: 'yaml', desc: 'output file type (yaml or json)'
    desc 'divide <spec_file> <output_dir> (<options>)', 'Divide the spec_file into path units and schema units.'

    def divide(spec_file, outdir)
      resolver = OasContrib::Resolver::Divide.new(spec_file, outdir, options)
      resolver.setup
      resolver.load
      resolver.resolve
      resolver.distribute
    end

    option :in_type, type: :string, default: 'yaml', desc: 'input file type (yaml or json)'
    desc 'merge <input_dir> <spec_file> (<options>)', 'Merge multiple divided files into an spec_file.'

    def merge(indir, spec_file)
      resolver = OasContrib::Resolver::Merge.new(indir, spec_file, options)
      resolver.setup
      resolver.load
      resolver.resolve
      resolver.distribute
    end

    option :port, type: :string, default: '50010', desc: 'Swagger UI listen port'
    desc 'preview <spec_file> (<options>)', 'Preview the spec_file using Swagger-UI official Docker image.'

    def preview(spec_file)
      resolver = OasContrib::Resolver::Preview.new(spec_file, options)
      resolver.setup
      resolver.distribute
    end
  end
end
