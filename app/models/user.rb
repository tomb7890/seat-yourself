class User < ActiveRecord::Base
  has_secure_password
  has_many :restaurants
  has_many :reservations
end
