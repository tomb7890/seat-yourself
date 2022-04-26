require 'test_helper'

class ReservationsTest < ActionDispatch::IntegrationTest

  setup do
    @restaurant = create(:restaurant)
    @restaurant_goer = create(:restaurant_goer)
    sign_in_as(@restaurant_goer)

    @r = default_reservation_options(@restaurant, @restaurant_goer)
  end

  def default_reservation_options(restaurant, user) 
    r = {                                                      
      "start_time(1i)": 2001,
          "start_time(2i)": 1,
          "start_time(3i)": 2,
          "start_time(4i)": 18, # 6pm
          "start_time(5i)": 0,
        partysize: 9,
        restaurant_id: restaurant.id,
        user_id: user.id
    }
    return r 
  end

  test "successful reservation creation " do

    assert_difference('Reservation.count', 1) do
      post restaurant_reservations_path(@restaurant.id) , params:{
      reservation: @r }
      
      assert_equal "Reservation added.", flash[:notice] 
    end
  end


  test "unsuccessful reservation creation when party size exceeds capacity " do
    @r[:partysize] = @restaurant.seating_capacity + 1 

    assert_no_difference('Reservation.count') do
      post restaurant_reservations_path(@restaurant.id) , params:{
      reservation: @r 
    }
     refute flash[:alert][/.*req.*party.*exceeds.*capacity/i].nil? 
    end
  end
  
  test "unsuccessful reservation creation when party size is zero " do
    @r[:partysize] = 0

    assert_no_difference('Reservation.count') do
      post restaurant_reservations_path(@restaurant.id) , params:{
      reservation: @r 
    }, xhr: true

    end
  end


  test "unsuccessful reservation creation when outside opening hours" do


    rx = {                                                      
      "start_time(1i)": 2001,
          "start_time(2i)": 1,
          "start_time(3i)": 1,
          "start_time(4i)": 23,
          "start_time(5i)": 30,
        partysize: 9,
        restaurant_id: @restaurant.id,
        user_id: @restaurant_goer.id
    }


    assert_no_difference('Reservation.count') do
      post restaurant_reservations_path(@restaurant.id) , params:{
      reservation: rx }
      

    end
  end


  
end
