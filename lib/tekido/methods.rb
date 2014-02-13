# coding: utf-8
module Tekido
  module Methods
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def yes?(percent = 50)
        percent_as(:float) <= percent
      end

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
        when :deca
          per.to_i / 10 * 10
        end
      end

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
