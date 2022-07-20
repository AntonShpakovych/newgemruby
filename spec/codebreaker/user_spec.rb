# frozen_string_literal: true

RSpec.describe Codebreaker::User do
  describe '.validate_for_name' do
    context 'when good name' do
      it 'good' do
        expect(described_class.validate_for_name('Anton')).to eq('Anton')
      end
    end

    context 'when bad name' do
      it 'raise' do
        expect do
          described_class.validate_for_name('1')
        end.to raise_error(StandardError, I18n.t(:name, min_length: Codebreaker::Validations::MIN_LENGTH,
                                                        max_length: Codebreaker::Validations::MAX_LENGTH))
      end
    end
  end
end
