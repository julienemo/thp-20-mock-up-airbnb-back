require_relative 'room'


class Reservation < ApplicationRecord
  validates :starting_date, :ending_date, :nb_bed_rented,   presence: true
  validates :status, inclusion: {in: ['on_going', 'paid', 'cancelled']}


  validate :starting_date_mustnt_be_in_the_past
  validate :ending_date_must_be_later_than_start
  validate :duration_cant_be_longer_than_31_days

  validate :no_over_renting


  belongs_to :guest, class_name: "User", foreign_key: "guest_id"
  belongs_to :room

  def starting_date_mustnt_be_in_the_past
    if starting_date < Date.today
      errors.add(:starting_date, "can't be in the past")
    end
  end

  def ending_date_must_be_later_than_start
    if starting_date >= ending_date
      errors.add(:ending_date, "must be later than starting date")
    end
  end

  def duration_cant_be_longer_than_31_days
    if starting_date + 31.days < ending_date
      errors.add(:ending_date, "A rental can't be more than a month")
    end
  end

  def no_over_renting
    available_bed = Room.find(room_id).nb_bed
    if nb_bed_rented > available_bed
      errors.add(:nb_bed_rented, "only #{available_bed} beds available !")
    end
  end

end
