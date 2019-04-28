class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.belongs_to :city, index: true
      t.references :admin, index: true
      # not sure whether to put foreign_key or index
      # it seem that foreign_key forces the entry to be one
      # that already exists in the dependant table
      # and not index: true
      # it also seems that we can put both
      # I did foreign_key in the first place
      # but couldn't migrate until I change back to index
      t.integer :nb_bed
      t.float :price_per_bed_pernight
      t.boolean :has_wifi
      t.text :description
      t.text :welcome_message
      t.timestamps
    end
  end
end
