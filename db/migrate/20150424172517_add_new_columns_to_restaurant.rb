class AddNewColumnsToRestaurant < ActiveRecord::Migration[4.2]
  def change
    add_column :restaurants, :open_hour, :time
    add_column :restaurants, :close_hour, :time

    add_reference :restaurants, :user
  end
end
