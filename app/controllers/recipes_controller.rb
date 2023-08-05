class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show update]

  def index
    @recipes = Recipe.includes([:user]).where(user_id: current_user.id).order(created_at: :desc)
  end

  def new
    @user = current_user
    @recipe = Recipe.new
  end

  def update
    return unless @recipe.update(recipe_params)

    respond_to do |format|
      format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
      format.js # Handles AJAX response
    end
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      redirect_to user_recipes_path(current_user.id), notice: 'Recipe Added successfully!'
    else
      render :show
    end
  end

  def show
    @recipe = Recipe.includes([:user]).find(params[:id])
    @recipe_foods = @recipe.recipe_foods.includes([:food])
  end

  def public
    @public_recipes = Recipe.includes(:foods, :user).where(public: true).order('created_at DESC')
  end

  def toggle
    @recipe = Recipe.find(params[:id])
    @recipe.public = !@recipe.public
    text = @recipe.public? ? 'public' : 'private'

    if @recipe.save
      flash[:notice] = "#{@recipe.name} is now #{text}!"
    elsif @recipe.errors.any?
      flash[:alert] = @recipe.errors.full_messages.first
    end
    redirect_to user_recipe_path(id: @recipe.id, user_id: current_user.id)
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to user_recipes_path(current_user.id), notice: 'Recipe deleted!'
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
