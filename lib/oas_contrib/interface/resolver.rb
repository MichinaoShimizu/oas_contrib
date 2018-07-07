module OasContrib
  module Interface
    module Resolver
      def setup
        raise NotImplementedError, 'You must be implement "setup" method.'
      end

      def load
        raise NotImplementedError, 'You must be implement "load" method.'
      end

      def resolve
        raise NotImplementedError, 'You must be implement "resolve" method.'
      end

      def distribute
        raise NotImplementedError, 'You must be implement"dist" method.'
      end
    end
  end
end
