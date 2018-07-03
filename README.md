# oas_contrib

[![Gem Version](https://badge.fury.io/rb/oas_contrib.svg)](https://badge.fury.io/rb/oas_contrib)

Libraries and commands for OpenAPI Specification.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'oas_contrib'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install oas_contrib

## Usage

### Divide command

Divide the OAS file into path units and schema units.

`$ oas_contrib divide <input_file_path> <output_directory_path> (OPTIONS)`

__Options__

* `--in_type`  input file type (`yaml` or `json`, default `yaml`)
* `--out_type` output file type (`yaml` or `json`, default `yaml`)

You can below 4 case:

* JSON OAS file -> JSON files
* YAML OAS file -> YAML files
* JSON OAS file -> YAML files
* YAML OAS file -> JSON files

### Merge command

Merge multiple divided files into an OAS file.

`$ oas_contrib merge <input_directory_path> <output_file_path> (OPTIONS)`

__Options__

* `--in_type`  input file type (`yaml` or `json`, default `yaml`)
* `--out_type` output file type (`yaml` or `json`, default `yaml`)

You can below 4 case:

* JSON files -> JSON OAS file
* YAML files -> YAML OAS file
* JSON files -> YAML OAS file
* YAML files -> JSON OAS file

### Preview command

Preview OAS file using Swagger-UI official Docker image.

The preview command needs docker.

`$ oas_contrib preview <input_file> (OPTIONS)`

__Options__

* `--port` Swagger UI listen port (default `50010`)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MichinaoShimizu/oas_contrib. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the OasContrib project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/MichinaoShimizu/oas_contrib/blob/master/CODE_OF_CONDUCT.md).
