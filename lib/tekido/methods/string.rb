# coding: utf-8
module Tekido
  module Methods
    module ClassMethods
      UPPER_CHARS = ('A'..'Z').to_a
      LOWER_CHARS = ('a'..'z').to_a
      NUMBER_CHARS = ('0'..'9').to_a
      EXAMPLE_DOMAINS = ["example.com", "exmple.net", "example.org"] +
                        ["example.jp", "example.co.jp", "example.ne.jp"] +
                        (0..9).map { |i| ["example#{i}.jp", "example#{i}.co.jp", "example#{i}.ne.jp"] }.flatten

      def string(options = {})
        size = size_from(options[:size])
        chars = chars_from(options[:chars], *options[:components])

        "".tap do |str|
          size.times do
            str << chars.sample
          end
        end
      end

      def email(base = nil)
        "#{string(size: 3..32, components: [:lower, :number])}@#{email_domain(base)}"
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

      def email_domain(base)
        if base.nil?
          EXAMPLE_DOMAINS.sample
        else
          base[base.index('@').to_i..base.size]
        end
      end
    end
  end
end


