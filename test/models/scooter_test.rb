require 'test_helper'

class ScooterTest < ActiveSupport::TestCase
  test "none available" do
    Scooter.all.each do |scooter|
      3.times do
        ride = Ride.new
        ride.set_end_time
        scooter.rides << ride
      end

      scooter.rides << Ride.new
    end


    assert_equal [], Scooter.available_scooters
  end

  test "scooter two available" do
    scooter = scooters(:one)
    3.times do
      ride = Ride.new
      ride.set_end_time
      scooter.rides << ride
    end

    scooter.rides << Ride.new


    scooter_two = Scooter.available_scooters.first

    assert_equal 1, Scooter.available_scooters.count
    assert_equal "two", scooter_two.special_id_code
  end
end
