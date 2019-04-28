class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.references :guest, index: true
      t.references :room, foreign_key: true
      t.integer :nb_bed_rented # validation, no more than the nb_bed available
      t.date :starting_date
      t.date :ending_date
      t.string :status # validation : choose from a list. ongoing, confirmed, paid, cancelled
      # t.text :host comment
      # t.text :guest comment
      t.timestamps
    end
  end
end
