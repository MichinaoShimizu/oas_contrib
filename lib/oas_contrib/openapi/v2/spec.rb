require 'oas_contrib/openapi/base'

module OasContrib
  # OpenAPI module
  module OpenAPI
    # Version 2 module
    module V2
      # Spec
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
