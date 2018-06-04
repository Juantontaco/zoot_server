class CreatePromoRedemptions < ActiveRecord::Migration
  def change
    create_table :promo_redemptions do |t|
      t.integer :invited_user_id
      t.integer :invite_sender_user_id
      t.datetime :invited_redeem_time
      t.datetime :invite_sender_redeem_time

      t.timestamps null: false
    end
  end
end
