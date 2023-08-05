require 'rails_helper'

RSpec.describe Food, type: :model do
  describe 'associations' do
    it 'should have correct associations' do
      expect(Food.reflect_on_association(:recipe_foods).macro).to eq(:has_many)
      expect(Food.reflect_on_association(:user).macro).to eq(:belongs_to)
    end
  end

  describe 'validations' do
    user = User.create(name: 'Harriet', email: 'exam@email.com', password: 'password',
                       password_confirmation: 'password')
    subject { Food.new(name: 'Apple', measurement_unit: 'grams', price: 5, quantity: 20, user_id: user.id) }

    it 'name should be present' do
      subject.name = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:name]).to include("can't be blank")
    end

    it 'price should be greater than or equal to zero' do
      subject.price = -1
      expect(subject).to_not be_valid
      expect(subject.errors[:price]).to include('must be greater than or equal to 0')
    end

    it 'quantity should be greater than or equal to zero' do
      subject.quantity = -1
      expect(subject).to_not be_valid
      expect(subject.errors[:quantity]).to include('must be greater than or equal to 0')
    end
  end
end
