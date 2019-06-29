lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oas_contrib/version'

Gem::Specification.new do |spec|
  spec.name          = 'oas_contrib'
  spec.version       = OasContrib::VERSION
  spec.authors       = ['Michinao Shimizu']
  spec.email         = ['shimizu.michinao@gmail.com']
  spec.summary       = 'Libraries and Commands for Open API (2.X, 3.X) Specification.'
  spec.description   = 'Divide OAS file (2.X, 3.X). Merge divided files to a OAS file. Preview OAS file with SwaggerUI Docker Container.'
  spec.homepage      = 'https://github.com/MichinaoShimizu/oas_contrib'
  spec.license       = 'MIT'
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_dependency 'thor', '~> 0.20'
  spec.add_development_dependency 'bundler', '~> 2.0.1'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
