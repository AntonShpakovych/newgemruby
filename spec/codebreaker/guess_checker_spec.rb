# frozen_string_literal: true

RSpec.describe Codebreaker::GuessChecker do
  let(:test_data) do
    [
      { check: { guess: %w[5 6 4 3], secret_code: %w[6 5 4 3] }, result: { index: 2, include: 2 } },
      { check: { guess: %w[6 4 1 1], secret_code: %w[6 5 4 3] }, result: { index: 1, include: 1 } },
      { check: { guess: %w[6 5 4 4], secret_code: %w[6 5 4 3] }, result: { index: 3, include: 0 } },
      { check: { guess: %w[3 4 5 6], secret_code: %w[6 5 4 3] }, result: { index: 0, include: 4 } },
      { check: { guess: %w[6 6 6 6], secret_code: %w[6 5 4 3] }, result: { index: 1, include: 0 } },
      { check: { guess: %w[2 6 6 6], secret_code: %w[6 5 4 3] }, result: { index: 0, include: 1 } },
      { check: { guess: %w[2 2 2 2], secret_code: %w[6 5 4 3] }, result: { index: 0, include: 0 } },
      { check: { guess: %w[1 6 6 1], secret_code: %w[6 6 6 6] }, result: { index: 2, include: 0 } },
      { check: { guess: %w[3 1 2 4], secret_code: %w[1 2 3 4] }, result: { index: 1, include: 3 } },
      { check: { guess: %w[1 5 2 4], secret_code: %w[1 2 3 4] }, result: { index: 2, include: 1 } },
      { check: { guess: %w[1 2 3 4], secret_code: %w[1 2 3 4] }, result: { index: 4, include: 0 } }
    ]
  end

  it 'check all data' do
    test_data.each do |data|
      expect(described_class.new(data[:check][:guess], data[:check][:secret_code]).check_guess).to eq(data[:result])
    end
  end
end
