class Reservation < ApplicationRecord
  belongs_to :guest, class_name: "User", foreign_key: "guest_id"
  belongs_to :room
end
