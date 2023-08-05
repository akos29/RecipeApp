require 'rails_helper'

RSpec.describe 'test recipe/index', type: :feature do
  before(:all) do
    @user = User.first
    sign_in @user
    @recipe = Recipe.create(name: 'Shiro', preparation_time: '6 months', cooking_time: '2 hours', description: 'Test',
                            public: true, user_id: @user.id)
  end

  scenario 'recipe name test' do
    visit user_recipes_path(@user)
    expect(page).to have_content(@recipe.name)
  end

  scenario 'recipe preparation_time test' do
    sign_in @user
    visit user_recipes_path(@user)
    expect(page).to_not have_content(@recipe.preparation_time)
  end

  scenario 'recipe cooking_time test' do
    sign_in @user
    visit user_recipes_path(@user)
    expect(page).to_not have_content(@recipe.cooking_time)
  end

  scenario 'recipe description test' do
    sign_in @user
    visit user_recipes_path(@user)
    expect(page).to have_content(@recipe.description)
  end
end
