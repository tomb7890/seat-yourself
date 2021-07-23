class AddLongitudeAndLatitudeToRestaurant < ActiveRecord::Migration[4.2]
  def change

    add_column :restaurants, :longitude, :decimal, precision: 9, scale: 6
    add_column :restaurants, :latitude, :decimal, precision: 9, scale: 6
  end
end
