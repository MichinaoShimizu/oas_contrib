require 'oas_contrib/openapi/base'

module OasContrib
  module OpenAPI
    module V3
      class Spec < OasContrib::OpenAPI::Base
        attr_reader :meta ,:path, :model

        def initialize(data)
          super
        end

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
