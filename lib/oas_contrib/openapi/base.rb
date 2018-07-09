require 'oas_contrib/interface/spec'

module OasContrib
  module OpenAPI
    # Basical spec class
    class Base
      # @!attribute [r] data
      #   @return [Hash] mapped spec data hash
      attr_reader :data

      include OasContrib::Interface::Spec

      # Initialize
      # @param [Hash] data spec data hash
      def initialize(data)
        @data = data
      end
    end
  end
end
