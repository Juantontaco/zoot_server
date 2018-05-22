class UsersController < ApplicationController
  before_action :authenticate_user!

  def check_if_in_ride
    @user = current_user

    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => {in_ride: @user.in_ride? } }
    end
  end

end
