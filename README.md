# oas_contrib

[![Gem Version](https://badge.fury.io/rb/oas_contrib.svg)](https://badge.fury.io/rb/oas_contrib)

Libraries and Commands for Open API (2.0, 3.0) Specification.

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

Divide the OAS file into path units and schema units.

```bash
$ oas_contrib divide <OAS file> <output_dir> (<options>...)
```

`<OAS file>` must be `.json` or `.yml`

#### Options

| option     | description      | value type                | default  |
|------------|------------------|---------------------------|----------|
|`--out_type`| output file type | String (`yaml` or `json`) | `yaml`   |


Merge multiple divided files into an OAS file.

```bash
$ oas_contrib merge <input_dir> <OAS file> (<options>...)
```

`<OAS file>` must be `.json` or `.yml`

#### Options

| option     | description      | value type               | default  |
|------------|------------------|------------------------- |----------|
|`--in_type` | input file type  | String (`yaml` or `json`)| `yaml`   |

### Preview command

Preview OAS file using Swagger-UI official Docker image.

The preview command needs docker.

```bash
$ oas_contrib preview <input_file> (<options>...)
```

`<input_file>` must be `.json` or `.yml`

#### Options

| option     | description             | value type      | default  |
|------------|-------------------------|-----------------|----------|
|`--port`    | Swagger UI listen port  | Integer         | `50010`  |

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MichinaoShimizu/oas_contrib. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the OasContrib project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/MichinaoShimizu/oas_contrib/blob/master/CODE_OF_CONDUCT.md).
