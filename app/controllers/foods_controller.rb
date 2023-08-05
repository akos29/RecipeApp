class FoodsController < ApplicationController
  before_action :set_food, only: %i[show edit destroy]
  before_action :authenticate_user!

  # GET /foods
  def index
    @foods = current_user.foods
  end

  # GET /foods/new
  def new
    @food = Food.new
  end

  # POST /foods
  def create
    @food = current_user.foods.new(food_params)
    @food.name = @food.name.titleize

    if @food.save
      redirect_to foods_url, notice: 'Food was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /foods/1
  def destroy
    @food.destroy

    redirect_to foods_url, notice: 'Food was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_food
    @food = Food.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
