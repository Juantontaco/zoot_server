class RidePingLocation < ActiveRecord::Base
  belongs_to :ride

  validates_presence_of :latitude, :longitude
end
