class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :restaurant, index: true, foreign_key: true
      t.datetime :time
      t.integer :partysize

      t.timestamps null: false
    end
  end
end
