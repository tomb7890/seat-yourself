class RemoveCategoryFromRestaurants < ActiveRecord::Migration[5.2]
  def change
    remove_column :restaurants, :category, :string
  end
end
