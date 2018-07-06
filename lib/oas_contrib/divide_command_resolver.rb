require 'oas_contrib/command_resolver'

module OasContrib
  #
  # <Description>
  #
  class DivideCommandResolver < CommandResolver
    def initialize(input_file_path, output_dir_path, output_file_type)
      @input_file_path = input_file_path
      @input_file_ext = File.extname(input_file_path)
      @output_file_ext = file_type_to_ext(output_file_type)
      super(output_dir_path)
    end

    #
    # <Description>
    #
    # @return [<Type>] <description>
    #
    def load
      input
    end

    # Output path definition files
    # @param [Hash] hash data source hash
    # @param [String] dir_path output directory path
    # @param [String] file_type output file type (yaml, json)
    # @return [Boolean]
    def dist
      output_multi(@spec.meta, @meta_dir)
      output_multi(@spec.path, @path_dir)
      output_multi(@spec.model, @model_dir)
    end
  end
end
