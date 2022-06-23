# frozen_string_literal: true

RSpec.describe Codebreaker::Statistics do
  let(:statistics) { described_class.new }

  describe 'statistics have validation' do
    it '.validate_file?' do
      allow(statistics).to receive(:validate_file?).and_return(true)
    end
  end

  describe 'logic' do
    let(:game) { Codebreaker::Game.new(user: Codebreaker::User.new('Anton1'), type_of_difficulty: :easy) }
    let(:permitted_classes) { [Codebreaker::User, Symbol].freeze }

    it '.add_to_data_store' do
      statistics.add_to_data_store(game)
      expect(statistics.instance_variable_get(:@data_store).length).to eq(1)
    end

    it '.save_unit' do
      statistics.add_to_data_store(game)
      statistics.save_unit
      expect(YAML.load_file(statistics.instance_variable_get(:@filename),
                            permitted_classes: permitted_classes,
                            aliases: true).length).to eq(1)
    end

    it '.show' do
      statistics.add_to_data_store(game)
      statistics.save_unit
      expect(statistics.show).to be_kind_of(Array)
    end

    it '.save_unit create_file' do
      statistics.add_to_data_store(game)
      statistics.save_unit
      expect(File.file?(statistics.instance_variable_get(:@filename))).to be(true)
    end

    it '.save_unit raise' do
      expect { statistics.save_unit }.to raise_error(StandardError, I18n.t(:empty_data))
    end
  end
end
