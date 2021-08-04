class Category < ApplicationRecord
  has_and_belongs_to_many :restaurants
  validates_uniqueness_of :name
end
