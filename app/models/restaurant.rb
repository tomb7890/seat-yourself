class Restaurant < ApplicationRecord

  has_many :reservations
  belongs_to :owner,  class_name: "User", foreign_key: "user_id"

  has_and_belongs_to_many :categories
  has_many :yelpreviews
  validates :name, :presence => true

  geocoded_by :address
  after_validation :geocode, if: :address_changed?


  def available?(party_size, start_time)
    party_size <= seating_capacity - reservations.where(start_time: start_time).sum(:partysize)
  end

end
