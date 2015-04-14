class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.integer :category_id, null: false
      t.integer :price
      t.timestamps null: false
    end
  end
end
