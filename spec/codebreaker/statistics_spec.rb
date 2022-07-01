# frozen_string_literal: true

RSpec.describe Codebreaker::Statistics do
  let(:statistics) { described_class.new }
  let(:user) { 'Anton' }
  let(:user2) { 'Stas' }
  let(:user3) { 'Anya' }
  let(:user4) { 'Vanya' }
  let(:difficulty) { :easy }
  let(:difficulty2) { :medium }
  let(:difficulty3) { :hell }
  let(:game) { Codebreaker::Game.new(user: user, type_of_difficulty: difficulty) }
  let(:game2) { Codebreaker::Game.new(user: user2, type_of_difficulty: difficulty3) }
  let(:game3) { Codebreaker::Game.new(user: user3, type_of_difficulty: difficulty3) }
  let(:game4) { Codebreaker::Game.new(user: user4, type_of_difficulty: difficulty2) }

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
    let(:result) { YAML.load_file(statistics.filename) }

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
    let(:data_sorted) do
      [
        { attempts_total: 5,
          attempts_used: 1,
          difficulty: difficulty3,
          hints_total: 1,
          hints_used: 1,
          user: 'Anya' },
        { attempts_total: 5,
          attempts_used: 4,
          difficulty: difficulty3,
          hints_total: 1,
          hints_used: 0,
          user: 'Stas' },
        { attempts_total: 10,
          attempts_used: 0,
          difficulty: difficulty2,
          hints_total: 1,
          hints_used: 0,
          user: 'Vanya' },
        { attempts_total: 15,
          attempts_used: 0,
          difficulty: difficulty,
          hints_total: 2,
          hints_used: 0,
          user: 'Anton' }
      ]
    end

    before do
      File.truncate(statistics.filename, 0)
      game2.instance_variable_set(:@attempts, 1)
      game3.instance_variable_set(:@attempts, 4)
      game3.instance_variable_set(:@hints, 0)
      statistics.add_to_data_store(game)
      statistics.add_to_data_store(game2)
      statistics.add_to_data_store(game3)
      statistics.add_to_data_store(game4)
      statistics.save_unit
    end

    it '#show gives sorted_data' do
      expect(statistics.show).to eq(data_sorted)
    end
  end
end
