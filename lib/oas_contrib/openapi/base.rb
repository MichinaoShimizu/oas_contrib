require 'oas_contrib/interface/spec'

module OasContrib
  module OpenAPI
    class Base
      attr_reader :data

      include OasContrib::Interface::Spec

      def initialize(data)
        @data = data
      end
    end
  end
end
