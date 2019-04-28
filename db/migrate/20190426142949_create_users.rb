class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.belongs_to :city, index: true
      # I want the user to be accepted even if he or she is from an undocumented place
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :description
      t.string :phone_nb
      t.timestamps
    end
  end
end
