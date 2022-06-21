# frozen_string_literal: true

RSpec.describe Codebreaker::Statistics do
  let(:statistics) { Codebreaker::Statistics.new }
  user1 = Codebreaker::User.new('Some user')
  game = Codebreaker::Game.new(user: user1, type_of_difficulty: :easy)
  permitted_classes = [Codebreaker::Game, Codebreaker::User, Symbol]

  context 'instances variables' do
    it 'have parameters' do
      instances_variables = %i[@filename @data_to_store]
      expect(statistics.instance_variables).to eq(instances_variables)
    end
  end

  context 'logic' do
    subject { statistics.add_to_statistics(game.data_to_save) }

    it '.add_to_statistics' do
      expect { subject }.to change { statistics.instance_variable_get(:@data_to_store).length }.from(0).to(1)
    end

    it 'show' do
      statistics.add_to_statistics(game.data_to_save)
      statistics.save_unit
      expect(statistics.show).to be_kind_of(Array)
    end

    context '.save_unit' do
      subject { [StandardError, "Don't have data for store"] }

      it '.save_unit increase length' do
        statistics.add_to_statistics(game)
        statistics.save_unit
        expect(YAML.load_file('default.yml', permitted_classes: permitted_classes, aliases: true).length).to eq(1)
      end

      it '.save_unit create_file' do
        statistics.add_to_statistics(game)
        statistics.save_unit
        expect(File.file?('default.yml')).to be(true)
      end

      it '.save_unit raise' do
        expect { statistics.save_unit }.to raise_error(StandardError, "Don't have data for store")
      end
    end
  end
end
