# frozen_string_literal: true

module Codebreaker
  class RandomSecretCode
    include Constants::Shared

    def self.call
      Array.new(LENGTH_GOOD) { Random.rand(CORRECT_RANGE).to_s }
    end
  end
end
