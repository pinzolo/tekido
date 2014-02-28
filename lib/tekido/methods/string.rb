# coding: utf-8
module Tekido
  module Methods
    module ClassMethods
      UPPER_CHARS  = [*'A'..'Z'].freeze
      LOWER_CHARS  = [*'a'..'z'].freeze
      NUMBER_CHARS = [*'0'..'9'].freeze
      EXAMPLE_DOMAINS = ["example.com", "exmple.net", "example.org"] +
                        ["example.jp", "example.co.jp", "example.ne.jp"] +
                        (0..9).map { |i| ["example#{i}.jp", "example#{i}.co.jp", "example#{i}.ne.jp"] }.flatten
      EXAMPLE_DOMAINS.freeze

      def string(options = {})
        size = size_from(options[:size])
        chars = chars_from(options[:chars], *options[:components])
        size.times.map { chars.sample }.join
      end

      def email(*bases)
        local = string(size: 3..32, components: [:lower, :number])
        domains = bases.empty? ? EXAMPLE_DOMAINS : bases.map { |b| b.index("@") ? b[b.index('@').to_i+1..b.size] : b }
        "#{local}@#{domains.sample}"
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


