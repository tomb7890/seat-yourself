require 'test_helper'

class RestaurantTest < ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  setup do
    @restaurant = create(:restaurant)
    Time.zone = @restaurant.time_zone
    @start_time =  Time.zone.local(2021, 8, 4,
                                13,0,0 )
  end
  
  def prepare_time_object(x) 
    Time.zone.local(2021,8,4,x,0,0)
  end
    
  test "availability at exactly the opening hour" do
    to =  prepare_time_object(@restaurant.open_hour)  
    assert @restaurant.hours_ok?(to)
  end

  test "availability at exactly the closing hour" do
    to = prepare_time_object( @restaurant.close_hour )
    refute  @restaurant.hours_ok?(to)
  end

  test "availability of last legitimate time" do
    to = prepare_time_object( @restaurant.close_hour - 1 )
    assert @restaurant.hours_ok?(to)
  end

  test "availability is denied for after hours parties" do
    to =  prepare_time_object( @restaurant.close_hour + 1)
    partysize = 9
    refute @restaurant.available?(partysize, to) 
  end 

  test "availability when party size is less than capacity" do
    party_size = 10
    assert @restaurant.available?(party_size, @start_time )
  end

  test "availability when party size is greater than capacity" do
    refute @restaurant.available?(@restaurant.seating_capacity + 1, @start_time )
  end

  test "availability when party size is exactly capacity" do
    assert @restaurant.available?(@restaurant.seating_capacity, @start_time ) 
  end

  # Restaurant#available? with existing reservations
  test "restaurant is available when reservations plus party size fits" do
    reservation = create(:reservation, restaurant: @restaurant)
    assert @restaurant.available?(25, @start_time )
  end

  test "reservation isn't available when reservations + party size > seating_capacity" do
    reservation = create(:reservation, restaurant: @restaurant, start_time: @start_time)
    party_size_to_be_tested  = @restaurant.seating_capacity - reservation.partysize + 1 
    refute @restaurant.available?(party_size_to_be_tested, @start_time )
  end

  test "reservation is available when reservations + party size are at different times" do
    reservation = create(:reservation, restaurant: @restaurant, start_time: @start_time)
    party_size_to_be_tested  = @restaurant.seating_capacity - reservation.partysize + 1 
    assert  @restaurant.available?(party_size_to_be_tested, @start_time + 3.weeks )
  end
end
