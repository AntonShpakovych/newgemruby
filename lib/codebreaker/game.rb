# frozen_string_literal: true

module Codebreaker
  class Game
    include Validations
    include Constants::Shared

    attr_reader :user, :secret_code, :attempts, :hints, :type, :secret_code_for_hints, :win

    def initialize(user:, type_of_difficulty:)
      @win = false
      @user = user
      @secret_code = secret
      @attempts = TYPE[type_of_difficulty][:attempts]
      @hints = TYPE[type_of_difficulty][:hints]
      @secret_code_for_hints = @secret_code.reverse
      @type = type_of_difficulty
    end

    def my_guess(guess)
      validate_for_guess(guess)
      raise(StandardError, I18n.t(:message_for_attempts)) unless @attempts.positive?

      cheacker = GuessChecker.new(guess.to_s.chars, @secret_code.chars).check_guess
      @result = cheacker
      @attempts -= 1
      @win = won?(@result)
      @result
    end

    def give_hints
      @hints.positive? ? check_hints(@secret_code_for_hints) : raise(StandardError, I18n.t(:message_for_hints))
    end

    def self.user_validate_in_game?(user_take)
      user_take.is_a?(User)
    end

    def self.type_of_difficulty_validate?(type_take)
      TYPE.key?(type_take.to_sym)
    end

    private

    def won?(session)
      session[:index] == 4
    end

    def secret
      RandomSecretCode.call
    end

    def check_hints(secret_code_for_hints)
      @hints -= 1
      secret_code_for_hints.slice!(rand(1...secret_code_for_hints.length)).to_i
    end
  end
end
