require 'oas_contrib/interface/spec'

module OasContrib
  # OpenAPI module
  module OpenAPI
    # Spec Base
    class Base
      # @!attribute data
      #   @return [<Type>] <description>
      attr_reader :data

      include OasContrib::Interface::Spec

      # Initialize
      # @param [Hash] data mapping data
      def initialize(data)
        @data = data
      end
    end
  end
end
