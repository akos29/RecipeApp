require 'rails_helper'

RSpec.describe 'Food index page', type: :feature do
  before(:example) do
    @user = User.first
    sign_in @user
    Food.create(name: 'Apple', measurement_unit: 'grams', price: 5, quantity: 4, user_id: @user.id)
    Food.create(name: 'Pineapple', measurement_unit: 'grams', price: 1, quantity: 2, user_id: @user.id)
    Food.create(name: 'Chicken breast', measurement_unit: 'units', price: 2, quantity: 1, user_id: @user.id)
    visit foods_path
  end

  describe "page's content" do
    it "should see the 'Add food' button" do
      expect(page).to have_content('Add food')
    end

    it 'should see names of all foods created by user' do
      @user.foods.each do |food|
        expect(page).to have_content food.name
      end
    end

    it 'should see the delete button ' do
      @user.foods.each do |_food|
        expect(page).to have_content('Delete')
      end
    end
  end

  describe 'clicking on "Add food" button' do
    it 'redirects to foods#new page' do
      click_link(href: new_food_path)
      expect(page).to have_current_path(new_food_path)
    end
  end
end
