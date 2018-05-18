class Scooter < ActiveRecord::Base
  has_many :rides

  def self.available_scooters
    all.select do |scooter|
      scooter.available?
    end
  end

  def available?
    is_available = true

    self.rides.each do |ride|
      is_available = is_available && !ride.active?
    end

    is_available
  end
end
