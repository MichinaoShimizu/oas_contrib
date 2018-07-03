require 'yaml'
require 'json'

module OasContrib
  # Command class utility
  module CommandUtil
    # @return [String]
    FILE_TYPE_YAML = 'yaml'.freeze
    # @return [String]
    FILE_TYPE_JSON = 'json'.freeze

    # Get directory, file paths
    # @param [String] root target root directory
    # @param [String] file_type yaml or json
    # @return [Array] meta file path, path direcotry path, schema directory path
    def env_paths(root, file_type)
      [
        "#{root}/meta#{file_type_ext(file_type)}",
        "#{root}/paths",
        "#{root}/components/schemas"
      ]
    end

    # Get file extension
    # @param [String] file_type yaml or json
    # @return [String] .yml or .json
    def file_type_ext(file_type)
      case file_type
      when FILE_TYPE_YAML then '.yml'
      when FILE_TYPE_JSON then '.json'
      end
    end

    # Get hash from yaml or json file
    # @param [String] path <description>
    # @param [String] file_type <description>
    # @return [Hash]
    def input_solo(path, file_type)
      case file_type
      when FILE_TYPE_YAML then YAML.load_file(path)
      when FILE_TYPE_JSON then JSON.parse(File.read(path))
      end
    end

    # Load path files and get hash
    # @param [String] dir_path target directory path
    # @param [String] file_type yaml or json
    # @return [Hash] parsed hash
    def input_multi(dir_path, file_type)
      path = "#{dir_path}/*#{file_type_ext(file_type)}"
      Dir.glob(path).each_with_object({}) do |input_file_path, result|
        hash = input_solo(input_file_path, file_type)
        key = hash.keys[0]
        result[key] = hash[key]
      end
    end

    # <Description>
    # @param [<Type>] hash <description>
    # @param [<Type>] path <description>
    # @param [<Type>] file_type <description>
    # @return [<Type>] <description>
    def output_solo(hash, path, file_type)
      output_lambda = case file_type
                      when FILE_TYPE_YAML then ->(file) { YAML.dump(hash, file) }
                      when FILE_TYPE_JSON then ->(file) { JSON.dump(hash, file) }
                      end
      File.open(path, 'w') { |f| output_lambda.call(f) }
    end

    # Output path definition files
    # @param [Hash] hash data source hash
    # @param [String] dir_path output directory path
    # @param [String] file_type output file type (yaml, json)
    # @return [Boolean]
    def output_multi(hash, dir_path, file_type)
      hash.each do |k, _|
        key = k.tr('/', '_').gsub(/^\_/, '')
        path = "#{dir_path}/#{key}#{file_type_ext(file_type)}"
        val = hash.select { |hash_key, _| hash_key == k }
        output_solo(val, path, file_type)
      end
    end

    # Return meta section hash
    # @param [Hash] hash data source hash
    # @return [Hash] filtered hash
    def meta_filter(hash)
      hash.select { |k, _| k != 'paths' && k != 'components' }
    end
  end
end
