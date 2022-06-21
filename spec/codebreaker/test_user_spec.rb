# frozen_string_literal: true

RSpec.describe Codebreaker::User do
  context 'instance variables' do
    let(:user) { Codebreaker::User.new('Username') }
    it 'have parameter name' do
      expect(user.instance_variables).to include(:@name)
    end

    it 'We can see name' do
      expect(user.name).to eq('Username')
    end
  end

  context 'user has validate' do
    subject { [StandardError, 'Name - string, required, min length - 3 symbols, max length - 20'] }
    it 'long name' do
      expect { Codebreaker::User.validate_for_name('AntonAntonAntonAnton21') }.to raise_error(*subject)
    end
    it 'short name' do
      expect { Codebreaker::User.validate_for_name('3') }.to raise_error(*subject)
    end
  end
end
