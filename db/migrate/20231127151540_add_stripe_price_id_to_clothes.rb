class AddStripePriceIdToClothes < ActiveRecord::Migration[7.0]
  def change
    add_column :clothes, :stripe_price_id, :string
  end
end
