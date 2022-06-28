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
      each_for_index(temp_hypothesis, temp_encryption)
      each_for_include(temp_hypothesis, temp_encryption)
      @store
    end

    private

    def for_index(temp_guess, index, temp_object)
      @store[:index] += 1
      temp_object.delete_at(index)
      temp_guess.delete_at(index)
    end

    def each_for_index(temp_guess, temp_object)
      temp_object.zip(temp_guess).map do |item_object, item_guess|
        for_index(temp_guess, temp_guess.index(item_object), temp_object) if item_object == item_guess
      end
    end

    def each_for_include(temp_guess, temp_object)
      @store[:include] += temp_object.length - (temp_object - temp_guess).length
    end
  end
end
