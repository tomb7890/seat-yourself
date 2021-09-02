class User < ApplicationRecord
  has_secure_password

  has_many :reservations
  has_many :restaurants, through: :reservations

  validates :name, presence: true
  validates :email, presence: true
  

end
