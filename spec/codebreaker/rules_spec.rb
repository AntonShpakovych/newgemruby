# frozen_string_literal: true

RSpec.describe Codebreaker::Rules do
  let(:correct_range_first) { Codebreaker::Constants::Shared::CORRECT_RANGE.first }
  let(:correct_range_last) { Codebreaker::Constants::Shared::CORRECT_RANGE.last }
  let(:length_good) { Codebreaker::Constants::Shared::LENGTH_GOOD }

  describe '.call' do
    it 'return rules of the game' do
      expect(described_class.call).to eq(I18n.t(:rules,
                                                correct_range_first: correct_range_first,
                                                correct_range_last: correct_range_last,
                                                length_good: length_good))
    end
  end
end
