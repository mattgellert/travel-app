class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.string :title
      t.text :blurb
      t.date :start_date
      t.date :end_date
      t.integer :intensity
      t.integer :user_id


      t.timestamps
    end
  end
end
