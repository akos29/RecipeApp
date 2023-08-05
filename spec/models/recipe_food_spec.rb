require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before :each do
    @user = User.create(name: 'Abebe', email: 'abebe@email.com', password: 'abebe123',
                        password_confirmation: 'abebe123')
    @recipe = Recipe.create(name: 'Doro wot', preparation_time: '6 hours', cooking_time: '2 hours',
                            description: 'Ethiopian cultural food', public: false, user_id: @user.id)
    @food = Food.create(name: 'Onion', measurement_unit: 'kg', price: 2, quantity: 5, user_id: @user.id)
  end
  it 'is valid' do
    recipe_food = RecipeFood.new(recipe_id: @recipe.id, food_id: @food.id, quantity: 2)
    expect(recipe_food).to be_valid
  end
  it 'should not be valid without quantity' do
    recipe_food = RecipeFood.new(recipe_id: @recipe.id, food_id: @food.id, quantity: nil)
    expect(recipe_food).to_not be_valid
  end
end
