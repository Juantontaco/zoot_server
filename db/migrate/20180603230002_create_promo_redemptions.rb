class CreatePromoRedemptions < ActiveRecord::Migration
  def change
    create_table :promo_redemptions do |t|
      t.references :invited_user
      t.references :invite_sender_user
      t.datetime :invited_redeem_time
      t.datetime :invite_sender_redeem_time

      t.timestamps null: false
    end
  end
end
