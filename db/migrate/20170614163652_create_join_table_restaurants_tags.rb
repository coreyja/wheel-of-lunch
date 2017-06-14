class CreateJoinTableRestaurantsTags < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurant_tags do |t|
      t.references :tag, index: true
      t.references :restaurant, index: true
      t.index %i(tag_id restaurant_id), unique: true
    end
  end
end
