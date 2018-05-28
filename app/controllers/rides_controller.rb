class RidesController < ApplicationController
  before_action :authenticate_user!

  def create
    scooter = Scooter.find_by_special_id_code params[:special_id_code]

    @ride = Ride.create(
      scooter: scooter,
      user: current_user,
      payment_source: params[:payment_source_id]
    )

    ## TODO: get location from user and update ride start_lat and start_long

    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @ride }
    end
  end

  def ping
    @ride = Ride.find_by_id params[:id]

    if @ride.scooter.active? && @ride.user == current_user
      latitude = params[:latitude]
      longitude = params[:longitude]

      @ride.ride_ping_locations << RidePingLocation.create(latitude: latitude, longitude: longitude)

      render :json => {success: true}
    else
      raise "Not Permitted"
    end
  end

  def show
    @ride = Ride.find_by_id params[:id]

    if @ride.nil?
      raise "Not Available"
    end

    if @ride.user != current_user
      raise "Not Permitted"
    end

    render :json => {ride: @ride, ride_ping_locations: @ride.ride_ping_locations}
  end

  def stop
    @ride = Ride.find_by_id params[:id]

    if @ride.active? && @ride.user == current_user
      @ride.set_end_time
    else
      raise "Not Permitted"
    end

    @ride.reload
    @ride.apply_charge_to_card

    ## TODO: get location from scooter and update

    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => {
        ride: @ride,
        calculated_cost: @ride.calculate_cost
      }}
    end
  end
end
