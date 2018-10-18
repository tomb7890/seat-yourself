class Restaurant < ActiveRecord::Base

  has_many :reservations
  belongs_to :owner,  class_name: "User", foreign_key: "user_id"

  validates :name, :presence => true

  geocoded_by :address
  after_validation :geocode, if: :address_changed?  
  
end
