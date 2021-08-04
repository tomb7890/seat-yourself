class ChangeStartTimeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :reservations, :time, :start_time
  end
end
