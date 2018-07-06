require 'oas_contrib/command_resolver'

module OasContrib
  #
  # <Description>
  #
  class MergeCommandResolver < CommandResolver
    def initialize(input_dir_path, output_file_path, input_file_type)
      @input_file_ext = file_type_to_ext(input_file_type)
      @output_file_path = output_file_path
      @output_file_ext = File.extname(output_file_path)
      super(input_dir_path)
    end

    #
    # <Description>
    #
    # @return [<Type>] <description>
    #
    def load
      load_meta
      resolve
      load_path
      load_model
    end

    #
    # <Description>
    #
    # @return [<Type>] <description>
    #
    def dist
      output
    end

    private

    def load_meta
      path = "#{@meta_dir}/**/*#{@input_file_ext}"
      @load_data = load_multi(path)
    end

    def load_path
      path = "#{@path_dir}/**/*#{@input_file_ext}"
      @load_data['paths'] = load_multi(path)
    end

    def load_model
      path = "#{@model_dir}/**/*#{@input_file_ext}"
      @load_data['definitions'] = load_multi(path) if swagger_v2?
      if openapi_v3?
        @load_data['components'] = {}
        @load_data['components']['schemas'] = load_multi(path)
      end
    end
  end
end
