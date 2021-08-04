class Yelpreview < ApplicationRecord
  belongs_to :restaurant
  validates_uniqueness_of :review
end
