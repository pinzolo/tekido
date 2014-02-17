# coding: utf-8
require "date"

module Tekido
  module Methods
    module ClassMethods
      def date(arg = nil)
        min, max = nil, nil
        if arg.nil?
          min, max = Date.new(1, 1, 1), Date.new(9999, 12, 31)
        elsif arg.is_a?(Integer)
          min, max = Date.new(arg, 1, 1), Date.new(arg, 12, 31)
        elsif arg.is_a?(Range)
          if arg.min.is_a?(Integer)
            min, max = Date.new(arg.min, 1, 1), Date.new(arg.max, 12, 31)
          elsif arg.min.is_a?(Date)
            min, max = arg.min, arg.max
          end
        end
        min ? min + integer((max - min).to_i) : nil
      end

      def birthday(arg = nil)
        if arg.nil?
          min = Date.today << 12 * 100
          date(min..Date.today)
        elsif arg.is_a?(Integer)
          min = (Date.today << 12 * (arg + 1)) + 1
          max = Date.today << 12 * arg
          date(min..max)
        elsif arg.is_a?(Range) && arg.min.is_a?(Integer)
          min = (Date.today << 12 * (arg.max + 1)) + 1
          max = Date.today << 12 * arg.min
          date(min..max)
        end
      end
    end
  end
end
