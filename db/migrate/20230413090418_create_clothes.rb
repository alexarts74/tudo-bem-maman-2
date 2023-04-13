class CreateClothes < ActiveRecord::Migration[7.0]
  def change
    create_table :clothes do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.string :image
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
