require 'test_helper'

class RestaurantsControllerTest < ActionController::TestCase

  setup do
    create(:user)
  end

  test "should create a restaurant" do
    assert_difference 'Restaurant.count'  do 
      post :create, params: { restaurant: { name: "Burrito Boyz", seating_capacity: 200}}
      assert_redirected_to restaurants_path
    end
  end

end
