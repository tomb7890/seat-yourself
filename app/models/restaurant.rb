class Restaurant < ActiveRecord::Base
  has_many :reservations
  belongs_to :owner,  class_name: "User", foreign_key: "user_id"

end
