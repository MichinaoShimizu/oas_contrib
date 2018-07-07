module OasContrib
  # OpenAPI
  module OpenAPI
    # Version 3 module
    module V3
      # Spec class
      class Spec
        attr_accessor :data, :meta, :path, :model

        # Initialize
        # @param [Hash] data mapping data
        def initialize(data)
          @data  = data
          @meta  = data.select { |v| v != 'paths' && v != 'components' } || nil
          @path  = data['paths'] || nil
          @model = data.dig('components', 'schemas') || nil
        end
      end
    end
  end
end
