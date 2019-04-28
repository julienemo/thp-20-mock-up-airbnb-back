class CreateJoinTableMessageRecipients < ActiveRecord::Migration[5.2]
  def change
    create_table :join_table_message_recipients do |t|
      t.references :private_message, foreign_key: true
      t.references :recipient, index: true
      t.string :status # validation : unread, read, deleted
      t.timestamps
    end
  end
end
