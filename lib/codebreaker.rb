# frozen_string_literal: true

require 'yaml'
require_relative 'codebreaker/helpers/rules'
require_relative 'codebreaker/helpers/type_of_difficulty'
require_relative 'codebreaker/helpers/guess'
require_relative 'codebreaker/helpers/hints'
require_relative 'codebreaker/helpers/randomsecret'
require_relative 'codebreaker/validations/validations'
require_relative 'codebreaker/user'
require_relative 'codebreaker/game'
require_relative 'codebreaker/helpers/statistics'
require_relative 'codebreaker/version'

module Codebreaker
end
# user1 = Codebreaker::User.new('Anya')
# game = Codebreaker::Game.new(user: user1, type_of_difficulty: :medium)
# user2 = Codebreaker::User.new('Anton')
# game1 = Codebreaker::Game.new(user: user2, type_of_difficulty: :easy)
# game1.my_guess(1231)
# game1.my_guess(1231)
# user3 = Codebreaker::User.new('Stas')
# game3 = Codebreaker::Game.new(user: user3, type_of_difficulty: :hell)
# game3.give_hints
# user4 = Codebreaker::User.new('Timur')
# game4 = Codebreaker::Game.new(user: user4, type_of_difficulty: :hell)
# game4.my_guess(1231)
# game4.my_guess(1231)
# game4.my_guess(1231)
# game4.my_guess(1231)
# statistics = Codebreaker::Statistics.new
# statistics.add_to_statistics(game4.data_to_save)
# statistics.save_unit
# statistics.add_to_statistics(game.data_to_save)
# statistics.add_to_statistics(game1.data_to_save)
# statistics.save_unit
# statistics.add_to_statistics(game3.data_to_save)
# statistics.save_unit
# puts statistics.show
