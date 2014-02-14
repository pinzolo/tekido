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

      def list(size, value_defs)
        range_and_values = range_and_values_from(value_defs)

        Array.new(size) do |i|
          per = percent_as(:float)
          match = range_and_values.find { |item| item.first.include?(per) }
          match ? match.last : nil
        end
      end

      def date(arg = nil)
        require 'date'
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
        require 'date'
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

      private
      def range_and_values_from(value_defs)
        if value_defs.is_a?(Array)
          range_and_values_from_array(value_defs)
        elsif value_defs.is_a?(Hash)
          range_and_values_from_value_ratios(value_defs)
        else
          []
        end
      end
      def range_and_values_from_array(values)
        [].tap do |array|
          values.each do |value|
            min = array.empty? ? 0.0 : array.last.first.max
            max = min + (100.0 / values.size)
            array << [(min..max), value]
          end
        end
      end

      def range_and_values_from_value_ratios(value_ratios)
        [].tap do |array|
          value_ratios.each do |value, ratio|
            min = array.empty? ? 0.0 : array.last.first.max
            max = min + ratio.to_f
            array << [(min..max), value]
          end
        end
      end
    end
  end
end
