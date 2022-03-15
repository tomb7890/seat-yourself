class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  validates :partysize, numericality: { greater_than_or_equal_to: 1,  only_integer: true }


  

  def format_time
    Time.zone =  restaurant.time_zone 
    start_time.in_time_zone.strftime('%A, %b %d %Y  at %H:%M:%S %Z %Y')
  end


end

