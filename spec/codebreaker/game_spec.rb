# frozen_string_literal: true

RSpec.describe Codebreaker::Game do
  let(:secret_code) { %w[1 2 3 1] }
  let(:user) { Codebreaker::User.new('Anton') }
  let(:difficulty) { :easy }
  let(:string_for_guess_good) { '1231' }
  let(:string_for_guess_bad) { '1289' }
  let(:data_i18n) { { length_good: 4, correct_range_first: 1, correct_range_last: 6 } }
  let(:game) { described_class.new(user: user, type_of_difficulty: difficulty) }
  let(:my_guess_good) { game.my_guess(string_for_guess_good) }
  let(:my_guess_bad) { game.my_guess(string_for_guess_bad) }

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

    context 'when game has @attempts' do
      let(:old_attempts_count) { 15 }

      it 'reduce attempts' do
        expect { my_guess_good }.to change(game, :attempts).from(old_attempts_count).to(old_attempts_count.pred)
      end
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

      it 'changes @win' do
        expect { my_guess_good }.to change(game, :win).from(false).to(true)
      end
    end
  end

  describe '#give_hints' do
    it 'give string' do
      expect(game.give_hints).to be_a_kind_of(String)
    end

    context 'when game has @hints' do
      let(:old_hints_count) { 2 }
      let(:old_secret_count) { 4 }
      let(:secret_code) { game.instance_variable_get(:@secret_code_for_hints) }

      it 'reduce hints' do
        expect { game.give_hints }.to change(game, :hints).from(old_hints_count).to(old_hints_count.pred)
      end

      it 'reduce secret_code_for_hints' do
        expect { game.give_hints }.to change(secret_code, :size).from(old_secret_count).to(old_secret_count.pred)
      end
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
        expect(described_class).to be_user_validate_in_game(user)
      end
    end

    context 'when bad user' do
      let(:bad_user) { 'Not instance User' }

      it 'bad user' do
        expect(described_class).not_to be_user_validate_in_game(bad_user)
      end
    end
  end

  describe '.type_of_difficulty_validate?' do
    context 'when good type' do
      let(:difficulty_key) { Codebreaker::Constants::Shared::TYPE_OF_DIFFICULTY.keys }

      it 'good type' do
        difficulty_key.each do |diff_type|
          expect(described_class).to be_type_of_difficulty_validate(diff_type)
        end
      end
    end

    context 'when bad type' do
      let(:somebadtype) { :this_type_not_in_type_if_difficulty }

      it 'bad type' do
        expect(described_class).not_to be_type_of_difficulty_validate(somebadtype)
      end
    end
  end
end
