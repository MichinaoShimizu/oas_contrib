module OasContrib
  # OpenAPI module
  module OpenAPI
    # Version 2 module
    module V2
      # Spec
      class Spec
        attr_accessor :data, :meta, :path, :model
        # Initialize
        # @param [Hash] data mapping data
        def initialize(data)
          @data  = data
          @meta  = data.select { |v| v != 'paths' && v != 'definitions' } || nil
          @path  = data['paths'] || nil
          @model = data['definitions'] || nil
        end
      end
    end
  end
end
