class AddSizeToClothes < ActiveRecord::Migration[7.0]
  def change
    add_column :clothes, :size, :string
  end
end
