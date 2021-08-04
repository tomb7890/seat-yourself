class AddRestaurantRefToYelpreviews < ActiveRecord::Migration[5.2]
  def change
    add_reference :yelpreviews, :restaurant, foreign_key: true
  end
end
