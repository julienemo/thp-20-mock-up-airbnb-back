require_relative 'room'


class Reservation < ApplicationRecord
  validates :starting_date, :ending_date, :nb_bed_rented, presence: true
  validates :status, inclusion: {in: ['on_going', 'paid', 'cancelled']}


  validate :starting_date_not_in_the_past
  validate :ending_date_must_be_later_than_start
  validate :duration_cant_be_longer_than_31_days

  validate :no_over_renting
  #validate :no_overlapping_resa
  validate :enough_beds_on_period

  belongs_to :guest, class_name: "User", foreign_key: "guest_id"
  belongs_to :room

  def covering?(date)
    (starting_date..ending_date).cover?(date)
  end

  private

  def starting_date_not_in_the_past
    if starting_date.present? && starting_date < Date.today
      errors.add(:starting_date, "can't be in the past")
    end
  end

  def ending_date_must_be_later_than_start
    if starting_date.present? &&
      ending_date.present? &&
      starting_date >= ending_date
      errors.add(:ending_date, "must be later than starting date")
    end
  end

  def duration_cant_be_longer_than_31_days
    if starting_date.present? &&
      ending_date.present? &&
      starting_date + 31.days < ending_date
      errors.add(:ending_date, "A rental can't be more than a month")
    end
  end

  def no_over_renting
    if nb_bed_rented.present? &&
      room.present? &&
      room.nb_bed < nb_bed_rented
      errors.add(:nb_bed_rented, "only #{room.nb_bed} beds available in the room!")
    end
  end

  def no_over_lapping_resa
    if starting_date.present? &&
      ending_date.present? &&
      room.reservations.where(
        '(starting_date, ending_date) OVERLAPS (?, ?)',
        starting_date,
        ending_date
      ).present?
      errors.add(:starting_date, "Room is rented for the selected dates")
    end
  end

  def enough_beds_on_period
    if starting_date.present? &&
      ending_date.present? &&
      room.present? #&& room.hostel?

      overlapping_reservations = room.reservations.where(
        '(starting_date, ending_date) OVERLAPS (?, ?)',
        starting_date,
        ending_date
      ).where(status: ['paid', 'on_going'])
      .where.not(nb_bed_rented: nil)

      overbooked_date = nil
      (starting_date..ending_date).each do |day|
        if overlapping_reservations
            .select { |r| r.covering?(day) }
            .sum(&:nb_bed_rented) + nb_bed_rented > room.nb_bed
          overbooked_date = day
          break
        end
      end

      if overbooked_date
        errors.add(:starting_date, "Not enough beds on date #{overbooked_date}")
      end
    end
  end
end
