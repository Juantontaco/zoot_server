class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.references :scooter, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
