module OasContrib
  module Swagger
    module V2
      class Spec
        attr_accessor :data, :meta, :path, :model

        def initialize(data)
          @data = data
          @meta = data.select { |v| v != 'paths' && v != 'definitions' } || nil
          @path = data['paths'] || nil
          @model = data['definitions'] || nil
        end
      end
    end
  end
end
