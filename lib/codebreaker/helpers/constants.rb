# frozen_string_literal: true

module Codebreaker
  module Constants
    module Shared
      WINNING_INDEX = 4
      LENGTH_GOOD = 4
      CORRECT_RANGE = (1..6)
      TYPE_OF_DIFFICULTY = { easy: { attempts: 15, hints: 2 },
                             medium: { attempts: 10, hints: 1 },
                             hell: { attempts: 5, hints: 1 } }.freeze
    end
  end
end
