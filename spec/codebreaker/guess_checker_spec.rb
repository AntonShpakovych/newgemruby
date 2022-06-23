# frozen_string_literal: true

RSpec.describe Codebreaker::GuessChecker do
  test_data = [
    [%w[5 6 4 3], %w[6 5 4 3], { index: 2, include: 2 }],
    [%w[6 4 1 1], %w[6 5 4 3], { index: 1, include: 1 }],
    [%w[6 5 4 4], %w[6 5 4 3], { index: 3, include: 0 }],
    [%w[3 4 5 6], %w[6 5 4 3], { index: 0, include: 4 }],
    [%w[6 6 6 6], %w[6 5 4 3], { index: 1, include: 0 }],
    [%w[2 6 6 6], %w[6 5 4 3], { index: 0, include: 1 }],
    [%w[2 2 2 2], %w[6 5 4 3], { index: 0, include: 0 }],
    [%w[1 6 6 1], %w[6 6 6 6], { index: 2, include: 0 }],
    [%w[3 1 2 4], %w[1 2 3 4], { index: 1, include: 3 }],
    [%w[1 5 2 4], %w[1 2 3 4], { index: 2, include: 1 }],
    [%w[1 2 3 4], %w[1 2 3 4], { index: 4, include: 0 }]
  ]
  test_data.each do |data|
    it "guess-#{data[0]} secret_code -#{data[1]} result -#{data[2]}" do
      expect(described_class.new(data[0], data[1]).check_guess).to eq(data[2])
    end
  end
end
