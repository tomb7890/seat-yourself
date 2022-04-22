class AddCloseHourToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :close_hour, :integer
  end
end
