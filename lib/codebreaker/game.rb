# frozen_string_literal: true

module Codebreaker
  class Game
    include Validations
    include Constants::Shared

    attr_reader :user, :attempts, :hints, :type, :win

    def initialize(user:, type_of_difficulty:)
      @win = false
      @user = user
      @secret_code = RandomSecretCode.call
      @attempts = TYPE_OF_DIFFICULTY[type_of_difficulty][:attempts]
      @hints = TYPE_OF_DIFFICULTY[type_of_difficulty][:hints]
      @secret_code_for_hints = @secret_code.shuffle
      @type = type_of_difficulty
    end

    def my_guess(guess)
      validate_for_guess(guess)
      raise(StandardError, I18n.t(:message_for_attempts)) unless @attempts.positive?

      @result = GuessChecker.new(guess.chars, @secret_code).check_guess
      @attempts -= 1
      @win = won?
      @result
    end

    def give_hints
      @hints.positive? ? check_hints : raise(StandardError, I18n.t(:message_for_hints))
    end

    def self.user_validate_in_game?(user)
      user.is_a?(User)
    end

    def self.type_of_difficulty_validate?(difficulty)
      TYPE_OF_DIFFICULTY.key?(difficulty.to_sym)
    end

    private

    def won?
      @result[:index] == WINNING_INDEX
    end

    def check_hints
      @hints -= 1
      @secret_code_for_hints.pop
    end
  end
end
