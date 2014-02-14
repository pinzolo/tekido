# coding: utf-8
module Tekido
  module Methods
    module ClassMethods
      def yes?(percent = 50)
        percent_as(:float) <= percent
      end
    end
  end
end

