class RideComment < ActiveRecord::Base
  belongs_to :ride

  validates_presence_of :star_count, :comment
end
