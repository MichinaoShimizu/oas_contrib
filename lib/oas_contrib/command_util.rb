require 'yaml'
require 'json'

module OasContrib
  # Command class utility
  module CommandUtil
    # @return [String]
    FILE_TYPE_YAML = 'yaml'.freeze
    # @return [String]
    FILE_TYPE_JSON = 'json'.freeze

    def definition_version(hash)
      if hash['swagger']
        puts 'OK. input file is swagger 2.0 format.'
        return 'v2'
      end

      if hash['openapi']
        puts 'OK. input file is openapi 3.0 format.'
        return 'v3'
      end

      raise 'input file must be swagger 2.0, or openapi 3.0 format.'
    end

    def schema_filter(hash, version)
      case version
      when 'v2' then hash['definitions']
      when 'v3' then hash['components']['schemas']
      end
    end

    def get_meta_file_path(root, file_type)
      "#{root}/meta#{file_type_ext(file_type)}"
    end

    def get_path_dir_path(root)
      "#{root}/paths"
    end

    def get_schema_dir_path(root, version)
      schema_path = case version
                    when 'v2' then '/definitions'
                    when 'v3' then '/components/schemas'
                    end

      "#{root}#{schema_path}"
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
      hash = case file_type
             when FILE_TYPE_YAML then YAML.load_file(path)
             when FILE_TYPE_JSON then JSON.parse(File.read(path))
             end

      puts "Load #{file_type} complete: #{path}"
      hash
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

      File.open(path, 'w') do |f|
        output_lambda.call(f)
        puts "Generate #{file_type} complete: #{path}"
      end
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
      hash.select { |k, _| k != 'paths' && k != 'components' && k != 'definitions' }
    end
  end
end
