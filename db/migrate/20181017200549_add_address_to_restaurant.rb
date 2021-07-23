class AddAddressToRestaurant < ActiveRecord::Migration[4.2]
  def change
    add_column :restaurants, :address, :string
  end
end
