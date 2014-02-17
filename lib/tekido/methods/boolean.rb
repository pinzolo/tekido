# coding: utf-8
module Tekido
  module Methods
    module ClassMethods
      def yes?(percent = 50)
        percent_as(:float) <= (percent.is_a?(Numeric) ? percent : 50)
      end
    end
  end
end

