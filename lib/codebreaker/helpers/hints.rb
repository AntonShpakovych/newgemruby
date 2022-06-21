# frozen_string_literal: true

module Hints
  MESSAGE_FOR_HINTS = 'You have not any hints left'

  def cheack_hints(secret_code_for_hints)
    index = rand(1...secret_code_for_hints.length)
    hint = secret_code_for_hints[index]
    secret_code_for_hints.slice!(index)
    @hints -= 1
    hint.to_i
  end
end
