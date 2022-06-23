# frozen_string_literal: true

module Codebreaker
  module Validations
    MAX_LENGTH = 20
    MIN_LENGTH = 3

    def self.included(base)
      base.send :include, InstanceMethods
      base.extend ClassMethods
    end

    module InstanceMethods
      include Constants::Shared

      def validate_for_guess(guess)
        raise(StandardError, I18n.t(:guess)) if guess.to_s.length != 4 || !guess.is_a?(Integer)

        guess.to_s.chars do |gues|
          raise(StandardError, I18n.t(:guess)) unless CORRECT_RANGE.include?(gues.to_i)
        end
      end
    end

    module ClassMethods
      def validate_for_name(name)
        condition = name.is_a?(String) && (name.length >= MIN_LENGTH && name.length <= MAX_LENGTH)
        condition ? name : raise(StandardError, I18n.t(:name, min_length: MIN_LENGTH, max_length: MAX_LENGTH))
      end
    end
  end
end
