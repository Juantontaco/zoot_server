class CreateRideComments < ActiveRecord::Migration
  def change
    create_table :ride_comments do |t|
      t.references :ride, index: true, foreign_key: true
      t.integer :star_count
      t.text :comment

      t.timestamps null: false
    end
  end
end
