class RidesController < ApplicationController
  before_action :authenticate_user!

  def create
    scooter = Scooter.find_by_special_id_code params[:special_id_code]

    @ride = create(
      scooter: scooter,
      user: current_user
    )

    ## TODO: get location from user and update ride start_lat and start_long

    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @ride }
    end
  end

  def stop
    @ride = Ride.find_by_id params[:id]

    if @ride.scooter.active? && @ride.user == current_user
      @ride.set_end_time
    end

    @calculated_cost = @ride.calculate_cost

    ## TODO: get location from user and update ride end_lat and end_long

    ## TODO: get location from scooter and update

    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => {
        ride: @ride,
        calculated_cost: @calculated_cost
      }}
    end
  end
end
