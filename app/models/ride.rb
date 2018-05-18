class Ride < ActiveRecord::Base
  belongs_to :scooter
  belongs_to :user

  BASE_FEE = 1
  PER_MINUTE_FEE = 0.15

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
      BASE_FEE + PER_MINUTE_FEE * ((end_time - created_at) / 60).to_i
    end
  end
end
