class RestaurantsController < ApplicationController

 include RestaurantsHelper

  def index
    @restaurants = fetch_list_of_restaurants(params)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit

  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new( restaurant_params )

    @restaurant.owner = User.first # temporary

    if @restaurant.save
      redirect_to restaurants_path
    else
      render :new
    end
  end

  def update

  end

  def destroy
  end


  private
  def restaurant_params
    params.require(:restaurant ).permit( :name, :description, :seating_capacity, :open_hour, :close_hour, :category )
  end
end
