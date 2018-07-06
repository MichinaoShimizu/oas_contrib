require 'oas_contrib/command_resolver_base'

module OasContrib
  # Command Resolvers
  module CommandResolvers
    # Merge command resolver
    class Merge < CommandResolverBase
      # Initialize
      # @param [String] input_dir_path input directory path
      # @param [String] output_file_path output file path
      # @param [String] input_file_type input file type (json or yaml)
      def initialize(input_dir_path, output_file_path, input_file_type)
        @input_file_ext = file_type_to_ext(input_file_type)
        @output_file_path = output_file_path
        @output_file_ext = File.extname(output_file_path)
        super(input_dir_path)
      end

      # Run
      # @return [nil]
      def run
        load
        resolve
        dist
      end

      # Load divided files
      # @return [Hash] load and merged data
      def load
        load_meta
        resolve
        load_path
        load_model
      end

      # Output the OAS file
      # @return [nil]
      def dist
        output(@load_data, @output_file_path)
      end

      private

      # Load meta part files
      # @return [Hash] loaded data
      def load_meta
        @load_data = input_dir(@meta_dir + '/**/*' + @input_file_ext)
      end

      # Load path part files
      # @return [Hash] load and merged data
      def load_path
        @load_data['paths'] = input_dir(@path_dir + '/**/*' + @input_file_ext)
      end

      # Load model part files
      # @return [Hash] load and merged data
      def load_model
        path = @model_dir + '/**/*' + @input_file_ext
        @load_data['definitions'] = input_dir(path) if swagger_v2?
        if openapi_v3?
          @load_data['components'] = {}
          @load_data['components']['schemas'] = input_dir(path)
        end
      end
    end
  end
end
