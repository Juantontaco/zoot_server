class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include DeviseTokenAuth::Concerns::User

  has_many :rides


  has_many :sent_promo_redemptions, :class_name => 'PromoRedemption', :foreign_key => 'invite_sender_user'
  has_many :received_promo_redemptions, :class_name => 'PromoRedemption', :foreign_key => 'invited_user'

  def in_ride?
    current_ride.present?
  end

  def current_ride
    self.rides.each do |ride|
      if ride.active?
        return ride
      end
    end

    nil
  end

  def close_all_rides
    self.rides.each do |ride|
      if ride.active?
        ride.set_end_time
      end
    end
  end

  def has_promo_redemption?
    PromoRedemption.user_has_redemption?(self)
  end

  def first_redemption
    PromoRedemption.find_redeemables_for_user(user).first
  end
end
