# oas_contrib

[![Gem Version](https://badge.fury.io/rb/oas_contrib.svg)](https://badge.fury.io/rb/oas_contrib)

Libraries and Commands for Open API (2.0, 3.0) Specification.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'oas_contrib'
```

And then execute:

    bundle

Or install it yourself as:

    gem install oas_contrib

## Usage

### sub commands
```bash
$ oas_contrib
Commands:
  oas_contrib divide <spec_file> <output_dir> (<options>)  # Divide the spec_file into path units and schema units.
  oas_contrib help [COMMAND]                               # Describe available commands or one specific command
  oas_contrib merge <input_dir> <spec_file> (<options>)    # Merge multiple divided files into an spec_file.
  oas_contrib preview <spec_file> (<options>)              # Preview the spec_file using Swagger-UI official Docker image.
```

### divide command
```bash
$ oas_contrib help divide
Usage:
  oas_contrib divide <spec_file> <output_dir> (<options>)

Options:
  [--out-ext=OUT_EXT]  # output file ext (.yml or .json)
                       # Default: .yml

Divide the spec_file into path units and schema units.
```

### merge command
#### I/F
```bash
$ oas_contrib help merge
Usage:
  oas_contrib merge <input_dir> <spec_file> (<options>)

Options:
  [--in-ext=IN_EXT]  # input file ext (.yml or .json)
                     # Default: .yml

Merge multiple divided files into an spec_file.
```

#### example
##### input
[v3.yml](/example/v3.yml)

##### execution
```
$ oas_contrib divide v3.yml sample
Load: v3.yml
Dist: sample/meta
Dist: sample/meta/001_openapi.yml
Dist: sample/meta/002_info.yml
Dist: sample/meta/003_servers.yml
Dist: sample/path
Dist: sample/path/001_pets.yml
Dist: sample/path/002_pets_{petId}.yml
Dist: sample/model
Dist: sample/model/001_Pet.yml
Dist: sample/model/002_Error.yml
Dist: sample/model/003_Pets.yml
complete!
```

##### output
```
$ tree sample/
sample/
├── meta
│   ├── 001_openapi.yml
│   ├── 002_info.yml
│   └── 003_servers.yml
├── model
│   ├── 001_Pet.yml
│   ├── 002_Error.yml
│   └── 003_Pets.yml
└── path
    ├── 001_pets.yml
    └── 002_pets_{petId}.yml
```
[output sample dir](/example/dist/v3)

### preview command
```bash
$ oas_contrib help preview
Usage:
  oas_contrib preview <spec_file> (<options>)

Options:
  [--port=N]  # Swagger UI listen port
              # Default: 50010

Preview the spec_file using Swagger-UI official Docker image.
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MichinaoShimizu/oas_contrib. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the OasContrib project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/MichinaoShimizu/oas_contrib/blob/master/CODE_OF_CONDUCT.md).
