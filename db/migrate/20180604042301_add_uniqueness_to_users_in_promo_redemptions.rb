class AddUniquenessToUsersInPromoRedemptions < ActiveRecord::Migration
  def change
    add_index :promo_redemptions, [:invited_user_id, :invite_sender_user_id], unique: true
  end
end
