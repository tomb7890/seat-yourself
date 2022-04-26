require 'test_helper'

class RestaurantTest < ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  setup do
    @restaurant = create(:restaurant)
    Time.zone = @restaurant.time_zone

    @start_time =  Time.zone.local(2021, 8, 4,
                                13,0,0 )
  end
  
  end


  # Restaurant#available? 
  test "restaurant is available when party size is less than capacity" do
    party_size = 10
    assert @restaurant.available?(party_size, @start_time )
  end

  test "restaurant is not available when party size is greater than capacity" do
    refute @restaurant.available?(@restaurant.seating_capacity + 1, @start_time )
  end

  test "restaurant is available when party size is exactly capacity" do
    assert @restaurant.available?(@restaurant.seating_capacity, @start_time ) 
  end

  # Restaurant#available? with existing reservations
  test "restaurant is available when reservations plus party size fits" do
    reservation = create(:reservation, restaurant: @restaurant)
    assert @restaurant.available?(25, @start_time )
  end

  test "reservation isn't available when reservations + party size > seating_capacity" do
    reservation = create(:reservation, restaurant: @restaurant)
    refute @restaurant.available?(97, @start_time )
  end

  test "reservation is available when reservations plus party size are at different times" do
    reservation = create(:reservation, restaurant: @restaurant)
    future_res_date = @start_time + 3.weeks
    future_party_size = @restaurant.seating_capacity
    assert @restaurant.available?(future_party_size, future_res_date)
  end
  
end
