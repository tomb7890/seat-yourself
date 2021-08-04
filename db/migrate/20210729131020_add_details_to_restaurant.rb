class AddDetailsToRestaurant < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :category, :string
    add_column :restaurants, :phone, :string
    add_column :restaurants, :pricerange, :string
    add_column :restaurants, :website, :string
    add_column :restaurants, :yelpurl, :string
  end
end
