module OasContrib
  module Interface
    module Spec
      def mapping
        raise NotImplementedError, 'You must be implement "mapping" method.'
      end
    end
  end
end
