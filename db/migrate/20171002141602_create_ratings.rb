class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.integer :stars
      t.text :note
      t.integer :destination_id
      t.integer :user_id
      t.timestamps
    end
  end
end
