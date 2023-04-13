class AddCategoryToClothes < ActiveRecord::Migration[7.0]
  def change
    add_column :clothes, :category, :string
  end
end
