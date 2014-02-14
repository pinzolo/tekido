# coding: utf-8
require "date"

module Tekido
  module Methods
    module ClassMethods
      def date(arg = nil)
        if arg.nil?
          Date.new(integer(9999), integer(12), integer(31))
        elsif arg.is_a?(Integer)
          Date.new(arg, integer(12), integer(31))
        elsif arg.is_a?(Range)
          if arg.min.is_a?(Integer) && arg.max.is_a?(Integer)
            Date.new(integer(arg), integer(12), integer(31))
          elsif arg.min.is_a?(Date) && arg.max.is_a?(Date)
            valid_day_count = (arg.max - arg.min).to_i
            arg.min + integer(valid_day_count)
          end
        end
      rescue
        date(arg)
      end

      def birthday(arg = nil)
        if arg.nil?
          min = Date.today << 12 * 100
          date(min..Date.today)
        elsif arg.is_a?(Integer)
          min = (Date.today << 12 * (arg + 1)) + 1
          max = Date.today << 12 * arg
          date(min..max)
        elsif arg.is_a?(Range) && arg.min.is_a?(Integer) && arg.max.is_a?(Integer)
          min = (Date.today << 12 * (arg.max + 1)) + 1
          max = Date.today << 12 * arg.min
          date(min..max)
        end
      end
    end
  end
end
