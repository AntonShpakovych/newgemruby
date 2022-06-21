# frozen_string_literal: true

module Codebreaker
  class RandomSecretCode
    RANGE = (1..6)
    def self.secret_code
      Array.new(4) { Random.rand(RANGE) }.join
    end
  end
end
