class Reservation < ApplicationRecord
  validates :starting_date, :ending_date, presence: true
  validates :status, inclusion: {in: ['on_going', 'paid', 'cancelled']}
  belongs_to :guest, class_name: "User", foreign_key: "guest_id"
  belongs_to :room


end
