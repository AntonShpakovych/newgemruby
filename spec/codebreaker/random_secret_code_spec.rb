# frozen_string_literal: true

RSpec.describe Codebreaker::RandomSecretCode do
  let(:randomsecretcode) { described_class.call }

  it '#call return string' do
    expect(randomsecretcode).to be_kind_of(String)
  end

  it '#call return string with length 4' do
    expect(randomsecretcode.length).to eq(4)
  end
end
