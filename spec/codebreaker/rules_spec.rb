# frozen_string_literal: true

RSpec.describe Codebreaker::Rules do
  it '#call return rules of the game' do
    expect(described_class.call).to eq(I18n.t(:rules,
                                              correct_range_first: 1,
                                              correct_range_last: 6,
                                              length_good: 4))
  end
end
