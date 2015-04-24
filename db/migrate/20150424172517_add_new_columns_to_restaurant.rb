class AddNewColumnsToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :open_hour, :time
    add_column :restaurants, :close_hour, :time

    add_reference :restaurants, :user
  end
end
