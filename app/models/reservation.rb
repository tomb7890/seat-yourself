class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  validates :partysize, numericality: { greater_than_or_equal_to: 1,  only_integer: true } 
end
