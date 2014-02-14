# coding: utf-8
module Tekido
  module Methods
    module ClassMethods
      def list(size, value_defs)
        range_and_values = range_and_values_from(value_defs)

        Array.new(size) do |i|
          per = percent_as(:float)
          match = range_and_values.find { |item| item.first.include?(per) }
          match ? match.last : nil
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


