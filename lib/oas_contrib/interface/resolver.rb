module OasContrib
  module Interface
    # Interface of Resolver class
    module Resolver
      # Setup the resolver object.
      # @return [nil]
      def setup
        raise NotImplementedError, 'You must be implement "setup" method.'
      end

      # Load and parse the input file.
      # @return [nil]
      def load
        raise NotImplementedError, 'You must be implement "load" method.'
      end

      # Judge and generate OpenAPI specification object.
      # @return [nil]
      def resolve
        raise NotImplementedError, 'You must be implement "resolve" method.'
      end

      # Distribute the command artifacts.
      # @return [nil]
      def distribute
        raise NotImplementedError, 'You must be implement"dist" method.'
      end
    end
  end
end
