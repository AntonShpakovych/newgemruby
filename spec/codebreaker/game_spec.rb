# frozen_string_literal: true

RSpec.describe Codebreaker::Game do
  let(:game) { described_class.new(user: Codebreaker::User.new('Anton'), type_of_difficulty: :easy) }

  describe '.my_guess' do
    it '.my_guess give hash' do
      expect(game.my_guess(1231)).to be_a_kind_of(Hash)
    end

    it '.my_guess has validation input' do
      expect { game.my_guess('1231') }.to raise_error(StandardError, I18n.t(:guess))
    end

    it '.my_guess reduce attempts' do
      expect { game.my_guess(1231) }.to change(game, :attempts).from(15).to(14)
    end

    it '.my_guess has validation attempts' do
      game.instance_variable_set(:@attempts, 0)
      expect { game.my_guess(1233) }.to raise_error(StandardError, I18n.t(:message_for_attempts))
    end

    context 'when my_guess = win' do
      before { game.instance_variable_set(:@secret_code, '1231') }

      it 'change @win' do
        expect { game.my_guess(1231) }.to change(game, :win).from(false).to(true)
      end
    end
  end

  describe '.give_hints' do
    it '.give_hints give integer' do
      expect(game.give_hints).to be_a_kind_of(Integer)
    end

    it '.give_hints reduce hints' do
      expect { game.give_hints }.to change(game, :hints).from(2).to(1)
    end

    it '.give_hints reduce secret_code_for_hints' do
      expect { game.give_hints }.to change(game.secret_code_for_hints, :size).from(4).to(3)
    end

    it '.give_hints has validation' do
      game.instance_variable_set(:@hints, 0)
      expect { game.give_hints }.to raise_error(StandardError, I18n.t(:message_for_hints))
    end
  end

  describe 'game_has_help_validation' do
    it '#user_validate_in_game? good user' do
      expect(described_class).to be_user_validate_in_game(Codebreaker::User.new('Anton'))
    end

    it '#user_validate_in_game? bad user' do
      expect(described_class).not_to be_user_validate_in_game('Some user')
    end

    it '#type_of_difficulty_validate? good type' do
      expect(described_class).to be_type_of_difficulty_validate(:easy)
    end

    it '#type_of_difficulty_validate? bad type' do
      expect(described_class).not_to be_type_of_difficulty_validate(:somebadkey)
    end
  end
end
