require 'oas_contrib/openapi/spec_base'

module OasContrib
  # OpenAPI module
  module OpenAPI
    # Version 2 module
    module V2
      # Spec
      class Spec < SpecBase
        # Initialize
        # @param [Hash] data mapping data
        def initialize(data)
          super
        end

        # Mapping
        # @return [OpenAPI::V2::Spec]
        def mapping
          @meta  = data.select { |v| v != 'paths' && v != 'definitions' } || nil
          @path  = data['paths'] || nil
          @model = data['definitions'] || nil
          self
        end
      end
    end
  end
end
