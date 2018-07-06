require 'oas_contrib/swagger/v2/spec'
require 'oas_contrib/openapi/v3/spec'
require 'yaml'
require 'json'

#
# <Description>
#
module OasContrib
  #
  # <Description>
  #
  class CommandResolver
    attr_accessor :spec

    def initialize(path)
      @meta_dir  = path + '/meta'
      @path_dir  = path + '/path'
      @model_dir = path + '/model'
    end

    #
    # <Description>
    #
    # @return [<Type>] <description>
    #
    def resolve
      return @spec = OasContrib::Swagger::V2::Spec.new(@load_data) if @load_data['swagger'] =~ /^2/
      return @spec = OasContrib::OpenAPI::V3::Spec.new(@load_data) if @load_data['openapi'] =~ /^3/
      raise 'Undefined OAS file.'
    end

    def openapi_v3?
      @spec.is_a?(OasContrib::OpenAPI::V3::Spec)
    end

    def swagger_v2?
      @spec.is_a?(OasContrib::Swagger::V2::Spec)
    end

    def file_type_to_ext(type)
      case type when 'yaml' then '.yml' when 'json' then '.json' else raise 'Undefined file type' end
    end

    def input(path = @input_file_path)
      @load_data = input_call(path)
    end

    def output(hash = @load_data, path = @output_file_path)
      File.open(path, 'w') { |f| output_call(hash, f) }
    end

    def load_multi(path)
      Dir.glob(path).sort.each_with_object({}, &input_call_lambda)
    end

    def input_call_lambda
      lambda do |file, result|
        hash = input_call(file)
        key = hash.keys[0]
        result[key] = hash[key]
      end
    end

    def input_call(path)
      puts "Load: #{path}"
      case @input_file_ext
      when '.yml'  then YAML.load_file(path)
      when '.json' then JSON.parse(File.read(path))
      end
    end

    def output_call(hash, file)
      puts "Dist: #{file.path}"
      case @output_file_ext
      when '.yml'  then YAML.dump(hash, file)
      when '.json' then JSON.dump(hash, file)
      end
    end

    def output_multi(hash, path)
      puts "Dist: #{path}"
      FileUtils.mkdir_p(path)
      i = 1
      hash.each do |k, _v|
        key = k.tr('/', '_').gsub(/^_/, '')
        val = hash.select { |hash_key, _| hash_key == k }
        output(val, "#{path}/#{i.to_s.rjust(3, '0')}_#{key}#{@output_file_ext}")
        i += 1
      end
    end
  end
end
