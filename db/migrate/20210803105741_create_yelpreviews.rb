class CreateYelpreviews < ActiveRecord::Migration[5.2]
  def change
    create_table :yelpreviews do |t|
      t.string :review

      t.timestamps
    end
  end
end
