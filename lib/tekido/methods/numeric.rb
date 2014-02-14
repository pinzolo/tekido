# coding: utf-8
module Tekido
  module Methods
    module ClassMethods
      def integer(arg = nil)
        if arg.nil?
          max = 2 ** 30 -1
          rand(0..max)
        else
          rand(arg).to_i
        end
      end

      def float(arg = nil)
        if arg.nil?
          rand
        elsif arg.is_a?(Range)
          rand(Range.new(arg.min.to_f, arg.max.to_f))
        else
          rand * arg.to_f
        end
      end
    end
  end
end
