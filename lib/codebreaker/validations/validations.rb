# frozen_string_literal: true

module Codebreaker
  module Validations
    include Constants::Shared

    MAX_LENGTH = 20
    MIN_LENGTH = 3

    def validate_for_name(name)
      (MIN_LENGTH..MAX_LENGTH).cover?(name.length) ? name : error('name')
    end

    def validate_for_guess(guess)
      error('guess') unless guess.length == LENGTH_GOOD && guess.match(/[1-6]{4}/)
    end

    def error(error_for)
      case error_for
      when 'name' then raise(StandardError, I18n.t(:name, min_length: MIN_LENGTH, max_length: MAX_LENGTH))
      when 'guess' then raise(StandardError, I18n.t(:guess,
                                                    length_good: LENGTH_GOOD, correct_range_first: CORRECT_RANGE.first,
                                                    correct_range_last: CORRECT_RANGE.last))
      end
    end
  end
end
