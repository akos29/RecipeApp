require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before :each do
    @user = User.create(name: 'Abebe', email: 'abebe@email.com', password: 'abebe123',
                        password_confirmation: 'abebe123')
    @user.save
  end
  it 'is valid' do
    recipe = Recipe.new(name: 'Miso Paste', preparation_time: '6 months', cooking_time: '2 hours', description: 'Test',
                        public: false, user_id: @user.id)
    expect(recipe).to be_valid
  end
  it 'should not be valid without a name' do
    recipe = Recipe.new(name: nil, preparation_time: '6 months', cooking_time: '2 hours', description: 'Test',
                        public: false, user_id: @user.id)
    expect(recipe).to_not be_valid
  end
  it 'should not be valid without cooking time' do
    recipe = Recipe.new(name: 'Miso Paste', preparation_time: '6 months', cooking_time: nil, description: 'Test',
                        public: false, user_id: @user.id)
    expect(recipe).to_not be_valid
  end
  it 'should not be valid without preparation time' do
    recipe = Recipe.new(name: 'Miso Paste', preparation_time: nil, cooking_time: '2 hours', description: 'Test',
                        public: false, user_id: @user.id)
    expect(recipe).to_not be_valid
  end
  it 'should not be valid without a description' do
    recipe = Recipe.new(name: 'Miso Paste', preparation_time: '6 months', cooking_time: '2 hours', description: nil,
                        public: false, user_id: @user.id)
    expect(recipe).to_not be_valid
  end
end
