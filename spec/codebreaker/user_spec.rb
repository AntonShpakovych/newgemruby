# frozen_string_literal: true

RSpec.describe Codebreaker::User do
  describe 'user has validate' do
    it '#validate_for_name good' do
      expect(described_class.validate_for_name('Anton')).to eq('Anton')
    end

    it '#validate_for_name bad' do
      expect do
        described_class.validate_for_name(1)
      end.to raise_error(StandardError, I18n.t(:name, min_length: 3,
                                                      max_length: 20))
    end
  end
end
