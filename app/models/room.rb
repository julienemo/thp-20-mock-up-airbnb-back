class Room < ApplicationRecord
  has_many :reservations
  has_many :guests, through: :reservations
  belongs_to :admin, class_name: "User", foreign_key: "admin_id"
  belongs_to :city
end
