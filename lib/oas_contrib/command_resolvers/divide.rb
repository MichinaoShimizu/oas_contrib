require 'oas_contrib/command_resolver_base'

module OasContrib
  # Command Resolvers
  module CommandResolvers
    # Divide command resolver
    class Divide < CommandResolverBase
      # Initialize
      # @param [String] input_file_path input file path
      # @param [String] output_dir_path output directory path
      # @param [String] output_file_type output file type (json or yaml)
      def initialize(input_file_path, output_dir_path, output_file_type)
        @input_file_path = input_file_path
        @input_file_ext  = File.extname(input_file_path)
        @output_file_ext = file_type_to_ext(output_file_type)
        super(output_dir_path)
      end

      # Load the OAS file
      # @return [Hash] loaded data
      def load
        input(@input_file_path)
      end

      # Output divided files
      # @return [nil]
      def dist
        output_dir(@spec.meta,  @meta_dir)
        output_dir(@spec.path,  @path_dir)
        output_dir(@spec.model, @model_dir)
      end
    end
  end
end
