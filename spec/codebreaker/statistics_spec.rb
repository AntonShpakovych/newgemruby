# frozen_string_literal: true

RSpec.describe Codebreaker::Statistics do
  let(:statistics) { described_class.new }
  let(:game) { Codebreaker::Game.new(user: Codebreaker::User.new('Anton1'), type_of_difficulty: :easy) }
  let(:permitted_classes) { [Codebreaker::User, Symbol].freeze }

  describe 'statistics have validation' do
    it 'validate_file?' do
      allow(statistics).to receive(:validate_file?).and_return(true)
    end
  end

  describe '#add_to_data_store' do
    before do
      statistics.add_to_data_store(game)
    end

    it 'add' do
      expect(statistics.instance_variable_get(:@data_store).length).to eq(1)
    end
  end

  describe '#save_unit' do
    let(:result) { YAML.load_file(statistics.filename, permitted_classes: permitted_classes, aliases: true) }

    context 'when data store not empty' do
      before do
        statistics.add_to_data_store(game)
        statistics.save_unit
      end

      it 'save' do
        expect(result.length).to eq(1)
      end

      it 'create_file' do
        expect(File.file?(statistics.instance_variable_get(:@filename))).to be(true)
      end
    end

    context 'when data_store empty' do
      before do
        statistics.instance_variable_set(:@data_store, [])
      end

      it 'raise' do
        expect { statistics.save_unit }.to raise_error(StandardError, I18n.t(:empty_data))
      end
    end
  end

  describe '#show' do
    let(:new_statistics) { described_class.new('someclearfile.yml') }

    context 'when good file' do
      before do
        statistics.add_to_data_store(game)
        statistics.save_unit
      end

      it 'give array' do
        expect(statistics.show).to be_kind_of(Array)
      end

      it 'array with hashes' do
        statistics.show.each do |hash|
          expect(hash.keys).to contain_exactly(:user,
                                               :attempts_total, :attempts_used, :difficulty, :hints_total, :hints_used)
        end
      end
    end

    context 'when bad file' do
      it "validate if file doesn't" do
        expect { new_statistics.show }.to raise_error(StandardError, I18n.t(:bad_file))
      end
    end
  end

  describe 'private sort_store' do
    data_sorted = [
      { user: 'Anton', difficulty: :hell, attempts_total: 5, attempts_used: 1, hints_total: 2, hints_used: 0 },
      { user: 'Stas', difficulty: :hell, attempts_total: 5, attempts_used: 3, hints_total: 2, hints_used: 2 },
      { user: 'Vanya', difficulty: :easy, attempts_total: 15, attempts_used: 1, hints_total: 4, hints_used: 0 }
    ]
    let(:sorted_data) { data_sorted }

    it 'return sorting array with hashes in correct order' do
      allow(statistics).to receive(:sort_store).and_return(sorted_data)
    end
  end
end
