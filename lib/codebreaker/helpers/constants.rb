# frozen_string_literal: true

module Codebreaker
  module Constants
    module Shared
      LENGTH_GOOD = 4
      CORRECT_RANGE = (1..6)
      CORRECT_RANGE_INDEX = (1...6)
      TYPE = { easy: { attempts: 15, hints: 2 },
               medium: { attempts: 10, hints: 1 },
               hell: { attempts: 5, hints: 1 } }.freeze
    end
  end
end
