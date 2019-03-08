class FoodsController < ApplicationController
  before_action :set_rest
  before_action :set_food, only: [:show, :update, :destroy]

  def index
    render json: @rest.foods
  end

  def show
    render json: @food
  end

  def create
    @food = @rest.foods.new(food_params)

    if @food.save
      render json: @food
    else
      render_error(@food)
    end
  end

  def update
    if @food.update(food_params)
      render json: @food
    else
      render_error(@food)
    end
  end

  def destroy
    @food.destroy
    render json: {message: "Removed"}, status: :ok
  end

  private
    def set_rest
      @rest = Rest.find(params[:rest_id])
    end

    def set_food
      @food = Food.find(params[:id])
    end

    def food_params
      params.require(:food).permit(:dish, :description)
    end
end
