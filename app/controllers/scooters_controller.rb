class ScootersController < ApplicationController
  before_action :authenticate_user!

  def index
    @scooters = Scooter.available_scooters

    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => { scooters: @scooters } }
    end
  end

  def show
    @scooter = Scooter.find_by_id(params[:id])

    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => { scooter: @scooter } }
    end
  end

  def update_location
    #must be scooter
  end
end
