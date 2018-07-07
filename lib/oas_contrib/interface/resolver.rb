module OasContrib
  module Interface
    # Resolver Interface
    module Resolver
      # Run
      # @raise [NotImplementedError]
      # @return [nil]
      def run
        raise NotImplementedError, 'You must be implement "run" method.'
      end

      # Run
      # @raise [NotImplementedError]
      # @return [nil]
      def setup
        raise NotImplementedError, 'You must be implement "setup" method.'
      end

      # Load
      # @raise [NotImplementedError]
      # @return [nil]
      def load
        raise NotImplementedError, 'You must be implement "load" method.'
      end

      # Distribute
      # @raise [NotImplementedError]
      # @return [nil]
      def dist
        raise NotImplementedError, 'You must be implement"dist" method.'
      end

      # Resolve
      # @raise [NotImplementedError]
      # @return [nil]
      def resolve
        raise NotImplementedError, 'You must be implement "resolve" method.'
      end
    end
  end
end
