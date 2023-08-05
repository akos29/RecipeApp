class UsersController < ApplicationController
  def shopping_list
    @recipes = Recipe.includes(:recipe_foods).where(user_id: current_user.id)
    @general_food_list = current_user.foods

    # Clone user's general food list
    general_food_list_clone = @general_food_list.clone

    # Negate quantity values of user's food list
    general_food_list_clone.map { |food| food.quantity = -food.quantity }

    # Loop through user's recipes and tally amount of various food items in the cloned list
    @recipes.each do |recipe|
      recipe.recipe_foods.each do |recipe_food|
        food = general_food_list_clone.find { |food_item| food_item.id == recipe_food.food_id }
        food.quantity = food.quantity + recipe_food.quantity
      end
    end

    # Select only foods with positive quantity values
    @lists = general_food_list_clone.select { |food| food.quantity.positive? }

    @total_value = 0
    # Loop throug lists and tally amounts
    @lists.each do |item|
      @total_value += item.price * item.quantity
    end
  end
end
