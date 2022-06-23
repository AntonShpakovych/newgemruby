# frozen_string_literal: true

module Codebreaker
  class GuessChecker
    attr_reader :store

    def initialize(guess, secret_code)
      @store = { index: 0, include: 0 }
      @encryption = secret_code
      @hypothesis = guess
    end

    def check_guess
      temp_encryption = @encryption.dup
      temp_hypothesis = @hypothesis.dup
      each_for_plus(temp_hypothesis, temp_encryption)
      each_for_minus(temp_hypothesis, temp_encryption)
      @store
    end

    private

    def for_plus(temp_guess, index, temp_object)
      @store[:index] += 1
      temp_object.delete_at(index)
      temp_guess.delete_at(index)
    end

    def each_for_plus(temp_guess, temp_object)
      initial_index = 0
      while initial_index < temp_guess.length
        if temp_guess[initial_index] == temp_object[initial_index]
          for_plus(temp_guess, initial_index, temp_object)
        else
          initial_index += 1
        end
      end
    end

    def each_for_minus(temp_guess, temp_object)
      temp_guess.to_s.chars.each do |gues|
        if temp_object.include?(gues)
          @store[:include] += 1
          temp_object.delete_at(temp_object.index(gues))
        end
      end
    end
  end
end
