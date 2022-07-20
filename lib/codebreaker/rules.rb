# frozen_string_literal: true

module Codebreaker
  class Rules
    include Constants::Shared

    def self.call
      I18n.t(:rules,
             correct_range_first: CORRECT_RANGE.first,
             correct_range_last: CORRECT_RANGE.last,
             length_good: LENGTH_GOOD)
    end
  end
end
