module OasContrib
  module Interface
    module Resolver
      def run
        raise NotImplementedError, 'You must be implement "run" method.'
      end

      def setup
        raise NotImplementedError, 'You must be implement "setup" method.'
      end

      def load
        raise NotImplementedError, 'You must be implement "load" method.'
      end

      def dist
        raise NotImplementedError, 'You must be implement"dist" method.'
      end

      def resolve
        raise NotImplementedError, 'You must be implement "resolve" method.'
      end
    end
  end
end
