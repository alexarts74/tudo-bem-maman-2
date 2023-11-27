class Clothe < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :name, :description, :price, presence: true

  def to_s
    name
  end

  after_create do
    clothe = Stripe::Product.create(name: name)
    price = Stripe::Price.create(product: clothe, unit_amount: self.price, currency: "eur")
    update(stripe_clothe_id: clothe.id)
  end
end
