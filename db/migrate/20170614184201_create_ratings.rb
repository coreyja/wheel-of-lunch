class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.references :restaurant, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.integer :rating, null: false

      t.timestamps
    end
  end
end
