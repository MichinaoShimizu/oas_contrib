require 'oas_contrib/openapi/base'

module OasContrib
  module OpenAPI
    # OpenAPI V2 module
    module V2
      # Spec class
      class Spec < OasContrib::OpenAPI::Base
        # @!attribute [r] meta
        #   @return [Hash] meta part
        attr_reader :meta

        # @!attribute [r] path
        #   @return [Hash] path part
        attr_reader :path

        # @!attribute [r] model
        #   @return [Hash] model part
        attr_reader :model

        # Initialize
        # @param [Hash] data spec data hash
        def initialize(data)
          super
        end

        # Mapping the hash to the spec object.
        # @return [OpenAPI::V2::Spec] mapped spec data object
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
