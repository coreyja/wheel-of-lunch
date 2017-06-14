class CreateRestaurants < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.integer :walking_minutes_away, index: true
      t.string :street_address
      t.string :phone_number
      t.string :menu_link

      t.timestamps
    end
  end
end
