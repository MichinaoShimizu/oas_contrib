require 'thor'
require 'oas_contrib/resolver/divide'
require 'oas_contrib/resolver/merge'
require 'oas_contrib/resolver/preview'

module OasContrib
  class Command < Thor
    include Thor::Actions

    desc 'divide <spec_file> <output_dir> (<options>)', 'Divide the spec_file into path units and schema units.'
    option :out_ext, type: :string, default: '.yml', desc: 'output file ext (.yml or .json)'

    def divide(spec_file, outdir)
      resolver = OasContrib::Resolver::Divide.new(spec_file, outdir, options)
      resolver.setup
      resolver.load
      resolver.resolve
      resolver.distribute
      say 'complete!', :green
    end

    desc 'merge <input_dir> <spec_file> (<options>)', 'Merge multiple divided files into an spec_file.'
    option :in_ext, type: :string, default: '.yml', desc: 'input file ext (.yml or .json)'

    def merge(indir, spec_file)
      resolver = OasContrib::Resolver::Merge.new(indir, spec_file, options)
      resolver.setup
      resolver.load
      resolver.resolve
      resolver.distribute
      say 'complete!', :green
    end

    desc 'preview <spec_file> (<options>)', 'Preview the spec_file using Swagger-UI official Docker image.'
    option :port, type: :numeric, default: 50_010, desc: 'Swagger UI listen port'

    def preview(spec_file)
      resolver = OasContrib::Resolver::Preview.new(spec_file, options)
      resolver.setup
      resolver.distribute
      say 'complete!', :green
    end
  end
end
