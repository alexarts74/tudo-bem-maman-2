class AddStripeClotheIdToClothes < ActiveRecord::Migration[7.0]
  def change
    add_column :clothes, :stripe_clothe_id, :string
  end
end
