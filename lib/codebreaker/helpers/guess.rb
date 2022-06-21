# frozen_string_literal: true

module Guess
  MESSAGE_FOR_ATTEMPTS = 'You have not any attempts left'

  def cheack_guess(guess, secret_code)
    @result.clear
    temp_secret = secret_code.dup
    temp_guess = guess.dup
    each_for_plus(temp_guess, temp_secret)
    each_for_minus(temp_guess, temp_secret)
    @attempts -= 1
    guess == secret_code ? @result.sort!.join << '(win)' : @result.sort!.join
  end

  private

  def for_plus(temp_guess, index, temp_object)
    @result << '+'
    temp_object.slice!(index)
    temp_guess.slice!(index)
  end

  def each_for_plus(temp_guess, temp_object)
    index = 0
    while index < temp_guess.length
      if temp_guess[index] == temp_object[index]
        for_plus(temp_guess, index, temp_object)
      else
        index += 1
      end
    end
  end

  def each_for_minus(temp_guess, temp_object)
    temp_guess.to_s.chars.each do |gues|
      if temp_object.include?(gues)
        @result << '-'
        temp_object.slice!(temp_object.index(gues))
      end
    end
  end
end
