# frozen_string_literal: true

RSpec.describe Codebreaker::Rules do
  describe '.call' do
    it 'return rules of the game' do
      expect(described_class.call).to eq(I18n.t(:rules,
                                                correct_range_first: Codebreaker::Constants::Shared::CORRECT_RANGE.last,
                                                correct_range_last: Codebreaker::Constants::Shared::CORRECT_RANGE.first,
                                                length_good: Codebreaker::Constants::Shared::LENGTH_GOOD))
    end
  end
end
