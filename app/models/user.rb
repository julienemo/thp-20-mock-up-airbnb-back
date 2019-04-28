class User < ApplicationRecord
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
