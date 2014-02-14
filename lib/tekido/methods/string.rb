# coding: utf-8
module Tekido
  module Methods
    module ClassMethods
      UPPER_CHARS = ('A'..'Z').to_a
      LOWER_CHARS = ('a'..'z').to_a
      NUMBER_CHARS = ('0'..'9').to_a

      def string(options = {})
        size = size_from(options[:size])
        chars = chars_from(options[:chars], *options[:components])

        "".tap do |str|
          size.times do
            str << chars.sample
          end
        end
      end

      private
      def size_from(option)
        base_size = integer(1..255)
        if option.nil?
          base_size
        elsif option.is_a?(Integer)
          option > 0 ? option : base
        elsif option.is_a?(Range)
          new_size = integer(option)
          new_size > 0 ? new_size : base
        end
      end

      def chars_from(chars, *components)
        return chars if chars.is_a?(Array) && !chars.empty?

        base_chars = UPPER_CHARS + LOWER_CHARS + NUMBER_CHARS
        return base_chars if components.nil? || components.empty?

        chars = []
        if components.include?(:upper)
          chars += UPPER_CHARS
        end
        if components.include?(:lower)
          chars += LOWER_CHARS
        end
        if components.include?(:number)
          chars += NUMBER_CHARS
        end
        chars.empty? ? base_chars : chars
      end
    end
  end
end


