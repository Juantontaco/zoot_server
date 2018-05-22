require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "in_ride? - false, bc all rides closed" do

    user = users(:one)


    3.times do
      ride = Ride.new
      ride.set_end_time
      user.rides << ride
    end


    assert_equal false, user.in_ride?
  end

  test "in_ride? - true bc last ride is active" do

    user = users(:one)


    3.times do
      ride = Ride.new
      ride.set_end_time
      user.rides << ride
    end

    ride = Ride.new
    user.rides << ride

    assert_equal true, user.in_ride?
  end
end
