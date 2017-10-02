class CreateDestinations < ActiveRecord::Migration[5.1]
  def change
    create_table :destinations do |t|
      t.string :name
      t.text :description
      t.string :address
      t.string :category # restaurant, hotel, attraction
      t.integer :location_id

      t.timestamps
    end
  end
end
