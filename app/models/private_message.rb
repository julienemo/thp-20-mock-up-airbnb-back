class PrivateMessage < ApplicationRecord
  validates :content, presence: true
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  has_many :join_table_message_recipients
  has_many :recipients, through: :join_table_message_recipients
end
