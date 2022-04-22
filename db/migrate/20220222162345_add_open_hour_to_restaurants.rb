class AddOpenHourToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :open_hour, :integer
  end
end
