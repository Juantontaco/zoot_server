class UsersController < ApplicationController
  before_action :authenticate_user!

  def check_if_in_ride
    @user = current_user

    in_ride = @user.in_ride?
    ride_id = nil

    if in_ride
      ride_id = @user.current_ride.id
    end

    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => {in_ride: in_ride, ride_id: ride_id } }
    end
  end

end
