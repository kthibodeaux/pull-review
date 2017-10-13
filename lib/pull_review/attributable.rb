module PullReview
  module Attributable
    module ClassMethods
      def attribute(*attributes)
        define_method(attributes.join('_').to_sym) do
          result = json_data

          attributes.each do |attribute|
            result = result.fetch(attribute.to_s)
          end

          result
        end
      end
    end

    def self.included(base)
      class << base
        include ClassMethods
      end
    end
  end
end
