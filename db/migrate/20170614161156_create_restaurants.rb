class CreateRestaurants < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurants do |t|
      t.string :name, null: false
      t.integer :walking_minutes_away, null: false, index: true
      t.string :street_address, null: false
      t.string :phone_number, null: true
      t.string :menu_link, null: true

      t.timestamps
    end
  end
end
