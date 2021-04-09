require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#validations' do
    let(:user) { build(:user) }
    it 'test that factory object is valid' do
      expect(user).to be_valid
    end

    it 'test that factory email sequence is valid' do
      user.save
      second_user = build(:user)
      expect(second_user).to be_valid
    end

    it 'test that has no email' do
      aggregate_failures do
        user.email = ''
        expect(user).not_to be_valid
        expect(user.errors[:email]).to include("can't be blank")
      end
    end

    it 'test that has invalid email' do
      aggregate_failures do
        user.email = 'abcd'
        expect(user).not_to be_valid
        expect(user.errors[:email]).to include("is invalid")

        user.email = 'user@'
        expect(user).not_to be_valid
        expect(user.errors[:email]).to include("is invalid")
      end
    end

    it 'test that has repeated email' do
      aggregate_failures do
        user.save
        invalid_user = build(:user, email: user.email)
        expect(invalid_user).not_to be_valid
        expect(invalid_user.errors[:email]).to include("has already been taken")
      end
    end
  end
end
