# frozen_string_literal: true

RSpec.describe Codebreaker::RandomSecretCode do
  let(:random_secret_code) { described_class.call }

  describe '.call' do
    it 'return array' do
      expect(random_secret_code).to be_kind_of(Array)
    end

    it "return array with length #{Codebreaker::Constants::Shared::LENGTH_GOOD}" do
      expect(random_secret_code.length).to eq(Codebreaker::Constants::Shared::LENGTH_GOOD)
    end

    it 'we expect digit 1-6' do
      expect(random_secret_code.join).to match(Codebreaker::Constants::Shared::REGULAR_FOR_CODE)
    end
  end
end
