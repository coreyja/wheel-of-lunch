class CreateJoinTableRestaurantsTags < ActiveRecord::Migration[5.1]
  def change
    create_join_table :restaurants, :tags do |t|
      t.index :tag_id
      t.index :restaurant_id
      t.index %i(tag_id restaurant_id), unique: true
    end
  end
end
