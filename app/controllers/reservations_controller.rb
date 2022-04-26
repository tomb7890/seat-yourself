class ReservationsController < ApplicationController

  before_action :load_restaurant
  before_action :ensure_logged_in, only: [:create, :destroy]



  def show
    @reservation = Reservation.find(params[:id])
  end


  def create
    Time.zone = @restaurant.time_zone
    @reservation = @restaurant.reservations.build(reservation_params)
    @reservation.user = current_user

    t = Time.zone.local( params[:reservation]["start_time(1i)"].to_i,
                         params[:reservation]["start_time(2i)"].to_i,
                         params[:reservation]["start_time(3i)"].to_i,
                         params[:reservation]["start_time(4i)"].to_i,
                         params[:reservation]["start_time(5i)"].to_i)
    
    desired_time = t.utc

    unless  @restaurant.hours_ok?(desired_time)
      redirect_to restaurant_path(@restaurant), alert: outside_normal_hours(t)
      return
    end

    desired_partysize = (reservation_params[:partysize]).to_i

    unless @restaurant.available?( desired_partysize, desired_time )
      redirect_to restaurant_path(@restaurant), alert: excessive_party_size(t)
      return
    end

    @reservation.start_time = desired_time
    if @reservation.save
      redirect_to restaurant_reservation_path(@restaurant, @reservation), notice: 'Reservation added.'
    else 
      # errors handled by create.js.erb 
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
  end

  private
  def outside_normal_hours(the_time)
    "Requested reservation at #{the_time.localtime} " + 
      " is not within opening hours. Please choose a time between " +
      " #{@restaurant.open_hour} and #{@restaurant.close_hour}."
  end

  def excessive_party_size(the_time)
    "Requested party size exceeds #{@restaurant.name}\'s seating capacity at #{the_time.localtime}."
  end
  
  def reservation_params
    params.require(:reservation).permit(:partysize, :start_time, :restaurant_id)
  end

  def load_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end


end
