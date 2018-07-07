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

### Divide command

Divide the OAS file into path units and schema units.

```bash
$ oas_contrib divide <OAS file> <output_dir> (<options>...)
```

`<OAS file>` must be `.json` or `.yml`

#### Options

| option     | description      | value type                | default  |
|------------|------------------|---------------------------|----------|
|`--out_type`| output file type | String (`yaml` or `json`) | `yaml`   |

#### Example

##### Open API 3.0

[BEFORE](https://github.com/MichinaoShimizu/oas_contrib/blob/master/example/v3.yml) -> [AFTER](https://github.com/MichinaoShimizu/oas_contrib/tree/master/example/dist/v3)

```
$ oas_contrib divide example/v3.yml example/dist/v3
Load: example/v3.yml
Dist: example/dist/v3/meta
Dist: example/dist/v3/meta/001_openapi.yml
Dist: example/dist/v3/meta/002_info.yml
Dist: example/dist/v3/meta/003_servers.yml
Dist: example/dist/v3/path
Dist: example/dist/v3/path/001_pets.yml
Dist: example/dist/v3/path/002_pets_{petId}.yml
Dist: example/dist/v3/model
Dist: example/dist/v3/model/001_Pet.yml
Dist: example/dist/v3/model/002_Error.yml

$ tree example/dist/v3/
example/dist/v3/
├── meta
│   ├── 001_openapi.yml
│   ├── 002_info.yml
│   └── 003_servers.yml
├── model
│   ├── 001_Pet.yml
│   ├── 002_Error.yml
│   └── 003_Pets.yml
└── path
    ├── 001_pets.yml
    └── 002_pets_{petId}.yml
```

##### Open API 2.0

[BEFORE](https://github.com/MichinaoShimizu/oas_contrib/blob/master/example/v2.yml) -> [AFTER](https://github.com/MichinaoShimizu/oas_contrib/tree/master/example/dist/v2)

```
$ oas_contrib divide example/v2.yml example/dist/v2
Load: example/v2.yml
Dist: example/dist/v2/meta
Dist: example/dist/v2/meta/001_swagger.yml
Dist: example/dist/v2/meta/002_info.yml
Dist: example/dist/v2/meta/003_host.yml
Dist: example/dist/v2/meta/004_basePath.yml
Dist: example/dist/v2/meta/005_schemes.yml
Dist: example/dist/v2/meta/006_consumes.yml
Dist: example/dist/v2/meta/007_produces.yml
Dist: example/dist/v2/meta/008_components.yml
Dist: example/dist/v2/path
Dist: example/dist/v2/path/001_pets.yml
Dist: example/dist/v2/path/002_pets_{petId}.yml
Dist: example/dist/v2/model
Dist: example/dist/v2/model/001_Pet.yml
Dist: example/dist/v2/model/002_Error.yml
Dist: example/dist/v2/model/003_Pets.yml

$ tree example/dist/
example/dist/
└── v2
    ├── meta
    │   ├── 001_swagger.yml
    │   ├── 002_info.yml
    │   ├── 003_host.yml
    │   ├── 004_basePath.yml
    │   ├── 005_schemes.yml
    │   ├── 006_consumes.yml
    │   ├── 007_produces.yml
    │   └── 008_components.yml
    ├── model
    │   ├── 001_Pet.yml
    │   ├── 002_Error.yml
    │   └── 003_Pets.yml
    └── path
        ├── 001_pets.yml
        └── 002_pets_{petId}.yml
```

### Merge command

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
