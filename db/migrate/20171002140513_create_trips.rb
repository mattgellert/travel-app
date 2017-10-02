class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.string :title
      t.integer :days
      t.integer :intensity
      t.integer :location_id
      t.integer :user_id

      t.timestamps
    end
  end
end
