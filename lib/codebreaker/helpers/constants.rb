# frozen_string_literal: true

module Codebreaker
  module Constants
    module Shared
      WINNING_INDEX = 4
      LENGTH_GOOD = 4
      CORRECT_RANGE = (1..6).freeze
      TYPE_OF_DIFFICULTY = { easy: { attempts: 15, hints: 2 },
                             medium: { attempts: 10, hints: 1 },
                             hell: { attempts: 5, hints: 1 } }.freeze

      REGULAR_FOR_CODE = /\A[#{CORRECT_RANGE.first}-#{CORRECT_RANGE.last}]{4}\z/.freeze
    end
  end
end
