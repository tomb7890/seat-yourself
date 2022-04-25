class Restaurant < ApplicationRecord

  has_many :reservations
  belongs_to :owner,  class_name: "User", foreign_key: "user_id"

  has_and_belongs_to_many :categories
  has_many :yelpreviews
  validates :name, :presence => true


  validates :open_hour, numericality: { only_integer: true,
                                        greater_than_or_equal_to: 1,
                                        less_than_or_equal_to: 24 }
  

  validates :close_hour, numericality: { only_integer: true,
                                         greater_than_or_equal_to: 1,
                                         less_than_or_equal_to: 24 }

  validates :seating_capacity, numericality: { only_integer: true } 

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def time_zone
    'Eastern Time (US & Canada)'
  end

  def hours_ok?(start_time)
    opening_hour = Time.zone.local(start_time.year,
                                start_time.month,
                                start_time.day,
                                open_hour,
                                0,
                                0 )

    closing_hour = Time.zone.local(start_time.year,
                                start_time.month,
                                start_time.day,
                                close_hour - 1,
                                0,
                                0 )

    start_time.localtime.between?(opening_hour, closing_hour)
  end


  def available?(party_size, start_time)
    return false unless hours_ok?(start_time) 
    party_size <= seating_capacity - reservations.where(start_time: start_time).sum(:partysize)
  end

  def time_zone
    ActiveSupport::TimeZone.new('America/Toronto')
  end

end
