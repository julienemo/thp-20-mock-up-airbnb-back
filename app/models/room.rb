class Room < ApplicationRecord
  validates :nb_bed, inclusion: { in: 1..8 }
  validates :price_per_bed_pernight, numericality: {greater_than: 0.99}
  validates :has_wifi, :test, presence: true
  # it's tricky to validate the content of a boolean
  validates :description, :welcome_message, length: {in: 30..2000}
  has_many :reservations
  has_many :guests, through: :reservations
  belongs_to :admin, class_name: "User", foreign_key: "admin_id"
  belongs_to :city

  private

  def test
    unless has_wifi == true || has_wifi == false
      errors.add(:has_wifi, 'no wifi')
    end
  end
end
