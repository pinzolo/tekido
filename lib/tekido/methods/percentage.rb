# coding: utf-8
module Tekido
  module Methods
    module ClassMethods
      def percent
        percent_as(:integer)
      end

      def percent_as(type)
        per = rand(0.0..100.0)
        case type
        when :float
          per
        when :integer
          per.to_i
        when :mo5
          per.to_i / 5 * 5
        when :deca, :mo10
          per.to_i / 10 * 10
        end
      end
    end
  end
end


