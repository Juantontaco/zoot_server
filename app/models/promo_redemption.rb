class PromoRedemption < ActiveRecord::Base
  belongs_to :invited_user, :class_name => 'User'
  belongs_to :invite_sender_user, :class_name => 'User'

  validate :cannot_invite_self

  def self.find_redeemables_for_user(user)
    invited_redemptions = where(invited_user: user).select do |promo_redemption|
      promo_redemption.can_redeem_for_user?(user)
    end

    sent_redemptions = where(invite_sender_user: user).select do |promo_redemption|
      promo_redemption.can_redeem_for_user?(user)
    end

    invited_redemptions.concat(sent_redemptions)
  end

  def self.user_has_redemption?(user)
    find_redeemables_for_user(user).count > 0
  end

  def self.user_already_has_redeemed_an_invite?(user)
    where(invited_user: user).select do |promo_redemption|
      promo_redemption.invited_redeem_time.present?
    end.count > 0
  end

  def can_redeem_for_user?(user)
    if invited_user == user
      invited_redeem_time.nil? && !PromoRedemption.user_already_has_redeemed_an_invite?(user)
    elsif invite_sender_user == user
      invite_sender_redeem_time.nil? && invited_user.rides.count > 0
    end
  end

  def redeem_for_user(user)
    if invited_user == user
      self.update_attributes(invited_redeem_time: DateTime.now)
    elsif invite_sender_user == user
      self.update_attributes(invite_sender_redeem_time: DateTime.now)
    end
  end

  def cannot_invite_self
    if invited_user == invite_sender_user
      errors.add(:invite_sender_user, "Cannot invite self")
    end
  end
end
