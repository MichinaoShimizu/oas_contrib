# OasContrib

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

`$ oas_contrib divide <input_file_path> <output_directory_path>`

#### Options

* `-it` input file type (yaml or json, default yaml)
* `-ot` output file type (yaml or json, default yaml)


### Merge command

Merge multiple divided files into an OAS file.

`$ oas_contrib merge <input_directory_path> <output_file_path>`

#### Options

* `-it` input file type (yaml or json, default yaml)
* `-ot` output file type (yaml or json, default yaml)

### Preview command

Preview OAS file using Swagger-UI official Docker image.

`$ oas_contrib preview <input_file>`

#### Options

* `-p` Swagger UI listen port (default `50010`)

#### Requires

The preview command needs docker.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MichinaoShimizu/oas_contrib. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the OasContrib project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/MichinaoShimizu/oas_contrib/blob/master/CODE_OF_CONDUCT.md).
