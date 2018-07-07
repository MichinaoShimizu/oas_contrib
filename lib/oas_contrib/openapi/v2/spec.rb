require 'oas_contrib/openapi/base'

module OasContrib
  module OpenAPI
    module V2
      class Spec < OasContrib::OpenAPI::Base
        attr_reader :meta, :path, :model

        def initialize(data)
          super
        end

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
