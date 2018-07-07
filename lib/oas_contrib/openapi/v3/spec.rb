require 'oas_contrib/openapi/base'

module OasContrib
  # OpenAPI
  module OpenAPI
    # Version 3 module
    module V3
      # Spec class
      class Spec < OasContrib::OpenAPI::Base
        # @!attribute [r] meta
        #   @return [<Type>] <description>
        attr_reader :meta
        # @!attribute [r] path
        #   @return [<Type>] <description>
        attr_reader :path
        # @!attribute [r] model
        #   @return [<Type>] <description>
        attr_reader :model

        # Initialize
        # @param [Hash] data mapping data
        def initialize(data)
          super
        end

        # Mapping
        # @return [OpenAPI::V3::Spec]
        def mapping
          @meta  = data.select { |v| v != 'paths' && v != 'components' } || nil
          @path  = data['paths'] || nil
          @model = data.dig('components', 'schemas') || nil
          self
        end
      end
    end
  end
end
