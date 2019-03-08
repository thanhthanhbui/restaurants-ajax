class RestsController < ApplicationController
  before_action :set_rest, only: [:show, :update, :destroy]

  def index
    @rests = Rest.all
  end

  def show
    render partial: 'rest', locals: { rest: @rest }
  end

  def form
    @rest = params[:id] ? Rest.find(params[:id]) : Rest.new
  end

  def create
    @rest = Rest.new(rest_params)

    if @rest.save
      render json: @rest
    else
      render_error(@rest)
    end
  end

  def update
    if @rest.update(rest_params)
      render json: @rest
    else
      render_error(@rest)
    end
  end

  def destroy
    @rest.destroy
    render json: {message: "Removed"}, status: :ok
  end

  private
    def set_rest
      @rest = Rest.find(params[:id])
    end

    def rest_params
      params.require(:rest).permit(:name, :description)
    end
end
