# frozen_string_literal: true

module Codebreaker
  class Game
    include TypeOfDifficulty
    include Validations
    include Guess
    include Hints

    def initialize(user:, type_of_difficulty:)
      @user = user
      @secret_code = secret
      @attempts = TYPE[type_of_difficulty][:attempts]
      @hints = TYPE[type_of_difficulty][:hints]
      @result = []
      @secret_code_for_hints = @secret_code.reverse
      @type = type_of_difficulty
      @attempts_total = TYPE[@type][:attempts]
      @hints_total = TYPE[@type][:hints]
    end

    def my_guess(guess)
      validate_for_guess(guess)
      @attempts.positive? ? cheack_guess(guess.to_s, @secret_code) : raise(StandardError, MESSAGE_FOR_ATTEMPTS)
    end

    def give_hints
      @hints.positive? ? cheack_hints(@secret_code_for_hints) : raise(StandardError, MESSAGE_FOR_HINTS)
    end

    def data_to_save
      { user: @user,
        difficulty: @type,
        attempts_total: @attempts_total,
        attempts_used: @attempts_total - @attempts,
        hints_total: @hints_total,
        hints_used: @hints_total - @hints }
    end

    def self.user_validate_in_game?(user_take)
      user_take.is_a?(User)
    end

    def self.type_of_difficulty_validate?(type_take)
      TYPE.key?(type_take)
    end

    private

    def secret
      RandomSecretCode.secret_code
    end
  end
end
