module OasContrib
  module OpenAPI
    module V3
      class Spec
        attr_accessor :data, :meta, :path, :model

        def initialize(data)
          @data = data
          @meta = data.select { |v| v != 'paths' && v != 'components' } || nil
          @path = data['paths'] || nil
          @model = data.dig('components', 'schemas') || nil
        end
      end
    end
  end
end
