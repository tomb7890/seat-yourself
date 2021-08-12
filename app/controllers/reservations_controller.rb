class ReservationsController < ApplicationController

before_action :load_restaurant
before_action :ensure_logged_in, only: [:create, :destroy]

def show
    @reservation = Reservation.find(params[:id])
  end

  def create
    @reservation = @restaurant.reservations.build(reservation_params)
    @reservation.user = current_user
    respond_to do |format|
      if @reservation.save
        format.html { redirect_to restaurant_url(@restaurant.id), notice: 'Reservation added.' }
        format.js {}
      else
        format.html { render 'restaurants/show', alert: 'There was an error.'  }
        format.js {}
      end
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
  end

  private
  def reservation_params
    params.require(:reservation).permit(:comment, :restaurant_id)
  end

  def load_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end


end
