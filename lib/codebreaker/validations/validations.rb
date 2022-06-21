# frozen_string_literal: true

module Validations
  NAME = 'Name - string, required, min length - 3 symbols, max length - 20'
  GUESS = 'Number, required, length - 4 digits, each digit is a number in the range 1-6'
  MAX_GUESS = 20
  MIN_GUESS = 3
  RANGE = (1..6)
  GUESS_LENGTH = 4

  def self.included(base)
    base.send :include, InstanceMethods
    base.extend ClassMethods
  end

  module InstanceMethods
    def validate_for_guess(guess)
      raise(StandardError, GUESS) if guess.to_s.length != 4 || !guess.is_a?(Integer)

      guess.to_s.chars do |gues|
        raise(StandardError, GUESS) unless RANGE.include?(gues.to_i)
      end
    end
  end

  module ClassMethods
    def validate_for_name(name)
      name.is_a?(String) && (name.length >= MIN_GUESS && name.length <= MAX_GUESS) ? name : raise(StandardError, NAME)
    end
  end
end
