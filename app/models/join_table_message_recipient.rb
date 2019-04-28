class JoinTableMessageRecipient < ApplicationRecord
  validates :recipient_id, :private_message_id, presence: true
  validates :status, inclusion: {in: ['read', 'unread']}

  validate :cant_send_to_self
  validate :cant_send_to_existing_recipient_of_same_message

  belongs_to :recipient, class_name: "User", foreign_key: "recipient_id"

  def cant_send_to_self
    sender_id = PrivateMessage.find(private_message_id).sender_id
    if recipient_id == sender_id
      errors.add(:recipient_id, "can't send message to oneself.")
    end
  end

  def cant_send_to_existing_recipient_of_same_message
    same_message = JoinTableMessageRecipient.where(private_message_id: private_message_id)
    if same_message.map{|msg| msg.recipient_id}.include? recipient_id
      errors.add(:recipient_id, "Recipient exists already for message #{private_message_id}")
    end
  end
end
