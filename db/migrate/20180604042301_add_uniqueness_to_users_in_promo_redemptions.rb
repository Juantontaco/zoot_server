class AddUniquenessToUsersInPromoRedemptions < ActiveRecord::Migration
  def change
    add_index :promo_redemptions, [:invited_user, :invite_sender_user], unique: true
  end
end
