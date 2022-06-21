# frozen_string_literal: true

RSpec.describe Codebreaker::Game do
  subject { Codebreaker::User.new('User1') }
  context 'instance variables' do
    let(:game) { Codebreaker::Game.new(user: subject, type_of_difficulty: :easy) }

    it 'have parameters' do
      instances_variables = %i[@user @secret_code @attempts @hints @result
                               @secret_code_for_hints @type @attempts_total @hints_total]
      expect(game.instance_variables).to eq(instances_variables)
    end
  end

  describe 'game has validations' do
    context 'user' do
      it '#user_validate_in_game? bad' do
        expect(Codebreaker::Game.user_validate_in_game?('Bad user')).to eq(false)
      end

      it '#user_validate_in_game? good' do
        expect(Codebreaker::Game.user_validate_in_game?(Codebreaker::User.new('Anton'))).to eq(true)
      end
    end

    context 'type_of_difficulty' do
      it '#type_of_difficulty_validate? bad' do
        expect(Codebreaker::Game.type_of_difficulty_validate?(:bad)).to eq(false)
      end

      it '#type_of_difficulty_validate? good' do
        expect(Codebreaker::Game.type_of_difficulty_validate?(:easy)).to eq(true)
      end
    end

    context 'guess' do
      subject { [StandardError, 'Number, required, length - 4 digits, each digit is a number in the range 1-6'] }
      let(:game) { Codebreaker::Game.new(user: Codebreaker::User.new('Anton'), type_of_difficulty: :easy) }
      context 'guess_type' do
        it '.my_guess bad1' do
          expect { game.my_guess(11) }.to raise_error(*subject)
        end

        it '.my_guess bad2' do
          expect { game.my_guess('1234') }.to raise_error(*subject)
        end

        it '.my_guess bad3' do
          expect { game.my_guess(1278) }.to raise_error(*subject)
        end

        it '.my_guess good' do
          expect(game.my_guess(1243)).not_to eq(false)
        end
      end
    end
  end

  describe 'logic' do
    let(:game) { Codebreaker::Game.new(user: Codebreaker::User.new('Anton'), type_of_difficulty: :easy) }

    context 'guess_attempts' do
      subject { [StandardError, 'You have not any attempts left'] }

      it '.my_guess reduces' do
        expect { game.my_guess(1231) }.to change { game.instance_variable_get(:@attempts) }.from(15).to(14)
      end

      it '.my_guess raise' do
        game.instance_variable_set(:@attempts, 0)
        expect { game.my_guess(1231) }.to raise_error(*subject)
      end
    end

    context 'hints' do
      subject { [StandardError, 'You have not any hints left'] }

      it '.give_hints' do
        expect(game.give_hints).to be_a_kind_of(Integer)
      end

      it '.give_hints reduces' do
        expect { game.give_hints }.to change { game.instance_variable_get(:@hints) }.from(2).to(1)
      end

      it '.give hints raise' do
        game.instance_variable_set(:@hints, 0)
        expect { game.give_hints }.to raise_error(*subject)
      end
    end

    context '.data_to_save' do
      it 'convert_data_to_good_type_for_save' do
        data = { user: game.instance_variable_get(:@user),
                 difficulty: game.instance_variable_get(:@type),
                 attempts_total: game.instance_variable_get(:@attempts_total),
                 attempts_used: game.instance_variable_get(:@attempts_total) - game.instance_variable_get(:@attempts),
                 hints_total: game.instance_variable_get(:@hints_total),
                 hints_used: game.instance_variable_get(:@hints_total) - game.instance_variable_get(:@hints) }
        expect(game.data_to_save).to eq(**data)
      end
    end
  end
end
