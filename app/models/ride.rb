class Ride < ActiveRecord::Base
  belongs_to :scooter
  belongs_to :user

  has_one :ride_comment

  has_many :ride_ping_locations

  validates_presence_of :payment_source

  BASE_FEE_IN_CENTS = 100
  PER_MINUTE_FEE_IN_CENTS = 15

  def active?
    if end_time.present?
      return !end_time.past?
    else
      return true
    end
  end

  def set_end_time(proposed_end_time = DateTime.now)
    self.update_attributes(end_time: proposed_end_time)
  end

  def calculate_cost
    if !active?
      BASE_FEE_IN_CENTS + PER_MINUTE_FEE_IN_CENTS * (((end_time - created_at) / 60).to_i)
    end
  end

  def apply_charge_to_card
    unless active?
      Charge.new.make_charge(calculate_cost, payment_source, user.stripe_customer_id)
    else
      puts "still active"
    end
  end
end
