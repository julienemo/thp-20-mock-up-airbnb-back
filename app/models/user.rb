require 'phonelib'
Phonelib.default_country = "FR"

class User < ApplicationRecord
  validates :email, uniqueness: true,
    format: {
      with: /\A[A-z0-9\._]*@[A-z0-9\._]*\.[A-z0-9\._]*\z/,
      # any time of anything amongst letters, digits dot and underscore
      # plus @
      # plus any time of anything amongst letters, digits dot and underscore
      # plus a dot
      # plus any time of blablabla
      # to represent a dot, escape needed \.
      # otherwise, "." in regex means "anything"
      message: "Please enter a valid email."
    }
  validates :first_name, :last_name, presence: {message: "First name and last name can't be empty."},
    format: {
      with: /\A[A-z\._]*\z/,
      message: "Please enter a valid name, without digit or special character. Only dot and underscore are allowed."
    }
  validates :description,
    length: {maximum: 50, message: "50 characters max."}
  validates :phone_nb, phone: true
    # phonelib validates numbers separated by dot, comma, hyphen, space
    # also international format +33, or 0033
    # also chinese format....dunno
  has_many :rooms, foreign_key: 'admin_id'
  # for line above
  # could have added "class_name'Room'"
  # coz class_name is the that of the object after 'has_many', or 'belongs_to'
  # but this class room is the the same of the default of the object
  # so no need to precise
  has_many :reservations, through: :rooms
  has_many :guests,through: :reservations,
    foreign_key: 'guest_id', class_name: 'User'

  has_many :private_messages, foreign_key: 'sender_id'
  has_many :join_table_message_recipients, through: :private_messages
  has_many :recipients,
    through: :join_table_message_recipients,
    foreign_key: 'recipient_id',
    class_name: 'User'

  # when we want to use the a.b method
  # we need to precise a has_many b (through multiple intermediaries if necessary)
  # otherwise, not every belongs_to need to have a corresponding has_many

  belongs_to :city
end
