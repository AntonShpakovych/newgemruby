# frozen_string_literal: true

module Codebreaker
  class User
    include Validations

    attr_reader :name

    def initialize(name)
      @name = name
    end
  end
end
