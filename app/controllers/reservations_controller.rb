class ReservationsController < ApplicationController

before_action :load_restaurant
before_action :ensure_logged_in, only: [:create, :destroy]



def show
    @reservation = Reservation.find(params[:id])
  end


#ReservationsController#create 
  def create 
    @reservation = @restaurant.reservations.build(reservation_params)
    @reservation.user = current_user

    desired_time = DateTime.new( params[:reservation]["start_time(1i)"].to_i,
                                 params[:reservation]["start_time(2i)"].to_i,
                                 params[:reservation]["start_time(3i)"].to_i,
                                 params[:reservation]["start_time(4i)"].to_i,
                                 params[:reservation]["start_time(5i)"].to_i)
    
    desired_partysize = (reservation_params[:partysize]).to_i

    if @restaurant.available?( desired_partysize, desired_time )
      if @reservation.save
        redirect_to restaurant_reservation_path(@restaurant, @reservation), notice: 'Reservation added.'
      else 
        # errors handled by create.js.erb 
      end
    else
      redirect_to restaurant_path(@restaurant), alert: "Requested party size exceeds #{@restaurant.name}\'s seating capacity at #{desired_time}."
    end
  end


  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
  end

  private
  def reservation_params
    params.require(:reservation).permit(:partysize, :start_time, :restaurant_id)
  end

  def load_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end


end
