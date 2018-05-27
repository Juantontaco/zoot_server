class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include DeviseTokenAuth::Concerns::User

  has_many :rides

  def in_ride?
    riding = false

    self.rides.each do |ride|
      riding = riding || ride.active?
    end

    riding
  end

  def current_ride
    self.rides.each do |ride|
      if ride.active?
        return ride
      end
    end

    nil
  end
end
