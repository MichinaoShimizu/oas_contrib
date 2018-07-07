require 'oas_contrib/openapi/spec_base'

module OasContrib
  # OpenAPI
  module OpenAPI
    # Version 3 module
    module V3
      # Spec class
      class Spec < SpecBase
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
