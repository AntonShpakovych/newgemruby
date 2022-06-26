# frozen_string_literal: true

RSpec.describe Codebreaker::Game do
  let(:secret_code) { %w[1 2 3 1] }
  let(:data_i18n) { { length_good: 4, correct_range_first: 1, correct_range_last: 6 } }
  let(:game) { described_class.new(user: Codebreaker::User.new('Anton'), type_of_difficulty: :easy) }
  let(:my_guess_good) { game.my_guess('1231') }
  let(:my_guess_bad) { game.my_guess('1298') }

  describe '#my_guess' do
    it 'give hash' do
      expect(my_guess_good).to be_a_kind_of(Hash)
    end

    it 'has validation input_bad_range' do
      expect { my_guess_bad }.to raise_error(StandardError,
                                             I18n.t(:guess,
                                                    length_good: data_i18n[:length_good],
                                                    correct_range_first: data_i18n[:correct_range_first],
                                                    correct_range_last: data_i18n[:correct_range_last]))
    end

    it 'reduce attempts' do
      expect { my_guess_good }.to change(game, :attempts).from(15).to(14)
    end

    context "when game dosn't have @attempts" do
      before do
        game.instance_variable_set(:@attempts, 0)
      end

      it 'has validation attempts' do
        expect { my_guess_good }.to raise_error(StandardError, I18n.t(:message_for_attempts))
      end
    end

    context 'when my_guess = win' do
      before { game.instance_variable_set(:@secret_code, secret_code) }

      it 'change @win' do
        expect { my_guess_good }.to change(game, :win).from(false).to(true)
      end
    end
  end

  describe '#give_hints' do
    it 'give integer' do
      expect(game.give_hints).to be_a_kind_of(String)
    end

    it 'reduce hints' do
      expect { game.give_hints }.to change(game, :hints).from(2).to(1)
    end

    it 'reduce secret_code_for_hints' do
      expect { game.give_hints }.to change(game.instance_variable_get(:@secret_code_for_hints), :size).from(4).to(3)
    end

    context "when game doesn't have @hints" do
      before do
        game.instance_variable_set(:@hints, 0)
      end

      it 'has validation' do
        expect { game.give_hints }.to raise_error(StandardError, I18n.t(:message_for_hints))
      end
    end
  end

  describe '.user_validate_in_game?' do
    context 'when good user' do
      it 'good user' do
        expect(described_class).to be_user_validate_in_game(Codebreaker::User.new('Anton'))
      end
    end

    context 'when bad user' do
      it 'bad user' do
        expect(described_class).not_to be_user_validate_in_game('Some user')
      end
    end
  end

  describe '.type_of_difficulty_validate?' do
    context 'when good type' do
      it 'good type' do
        expect(described_class).to be_type_of_difficulty_validate(:easy)
      end
    end

    context 'when bad type' do
      it 'bad type' do
        expect(described_class).not_to be_type_of_difficulty_validate(:somebadtype)
      end
    end
  end
end
