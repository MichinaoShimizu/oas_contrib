module OasContrib
  module Interface
    # Interface of Spec class
    module Spec
      # Mapping the hash to the spec object.
      # @return [nil]
      def mapping
        raise NotImplementedError, 'You must be implement "mapping" method.'
      end
    end
  end
end
