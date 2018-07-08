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

### Common rule

* The file extension of `<OpenAPI Specification file>` must be `.json` or `.yml`.
* `<OpenAPI Specification file>` must be has the section of `swagger: 2.0.X` or `openapi: 3.0.X`.

### Divide the OpenAPI Specification file

```bash
oas_contrib divide <OpenAPI Specification file> <output_dir> (<options>...)
```

| option     | description                  | value type                 | default  |
|------------|------------------------------|----------------------------|----------|
|`--out_ext` | the extension of output file | String (`.json` or `.yml`) | `.yml`   |

### Merge from divided files to an OpenAPI Specification file

```bash
oas_contrib merge <input_dir> <OpenAPI Specification file> (<options>...)
```

| option     | description                  | value type                 | default  |
|------------|------------------------------|----------------------------|----------|
|`--in_ext`  | the extension of input  file | String (`.json` or `.yml`) | `.yml`   |

### Preview the OpenAPI Specification file using Swagger-UI docker image

```bash
oas_contrib preview <OpenAPI Specification file> (<options>...)
```

| option     | description             | value type      | default  |
|------------|-------------------------|-----------------|----------|
|`--port`    | Swagger UI listen port  | Integer         | `50010`  |

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MichinaoShimizu/oas_contrib. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the OasContrib project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/MichinaoShimizu/oas_contrib/blob/master/CODE_OF_CONDUCT.md).
