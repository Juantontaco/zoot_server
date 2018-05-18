class CreateScooters < ActiveRecord::Migration
  def change
    create_table :scooters do |t|
      t.string :special_id_code
      t.integer :battery

      t.timestamps null: false
    end
  end
end
