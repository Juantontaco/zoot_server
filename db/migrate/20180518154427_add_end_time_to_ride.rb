class AddEndTimeToRide < ActiveRecord::Migration
  def change
    add_column :rides, :end_time, :datetime
  end
end
