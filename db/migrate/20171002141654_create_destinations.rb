class CreateDestinations < ActiveRecord::Migration[5.1]
  def change
    create_table :destinations do |t|
      t.string :name
      t.text :description
      t.string :address
      t.string :category # restaurant, hotel, attraction
      t.integer :location_id
      t.string :photo_url_1
      t.string :photo_url_2
      t.string :photo_url_3

      t.timestamps
    end
  end
end
