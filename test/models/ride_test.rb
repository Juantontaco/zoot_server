require 'test_helper'

class RideTest < ActiveSupport::TestCase
  test "active? bc it is null" do
    ride = rides(:one)

    assert_equal true, ride.active?
  end

  test "active? bc it is set in past" do
    ride = rides(:one)

    ride.end_time = 1.minute.ago

    assert_equal false, ride.active?
  end


  test "active? bc it is set in future (should be false)" do
    ride = rides(:one)

    ride.end_time = 1.day.from_now

    assert_equal true, ride.active?
  end

  test "set_end_time" do
    ride = rides(:one)

    ride.set_end_time

    sleep 0.1

    assert_equal false, ride.active?
  end

  test "set_end_time in future (should remain active)" do
    ride = rides(:one)

    ride.set_end_time(1.hour.from_now)

    sleep 0.1

    assert_equal true, ride.active?
  end

  test "calculate_cost for future end_time to be nil" do
    ride = rides(:one)

    ride.set_end_time(1.hour.from_now)

    sleep 0.1

    assert_nil ride.calculate_cost
  end

  test "calculate_cost for 80 second ride to be 1.15" do
    ride = rides(:one)

    ride.update_attributes(created_at: 80.seconds.ago)
    ride.set_end_time

    sleep 0.1

    assert_equal 1.15, ride.calculate_cost
  end

  test "calculate_cost for 180 second ride to be 1.45" do
    ride = rides(:one)

    ride.update_attributes(created_at: 180.seconds.ago)
    ride.set_end_time

    sleep 0.1

    assert_equal 1.45, ride.calculate_cost
  end
end
