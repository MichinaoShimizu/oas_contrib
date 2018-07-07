module OasContrib
  # OpenAPI module
  module OpenAPI
    # Spec Base
    class SpecBase
      attr_accessor :data, :meta, :path, :model
      # Initialize
      # @param [Hash] data mapping data
      def initialize(data)
        @data = data
      end
    end
  end
end
