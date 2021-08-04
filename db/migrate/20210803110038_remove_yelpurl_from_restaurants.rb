class RemoveYelpurlFromRestaurants < ActiveRecord::Migration[5.2]
  def change
    remove_column :restaurants, :yelpurl, :string
  end
end
