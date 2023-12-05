class Clothe < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :name, :description, :price, :category, :size, presence: true

  def to_s
    name
  end

  def to_builder
    Jbuilder.new do |clothe|
      clothe.price stripe_price_id
      clothe.quantity 1
    end
  end

  after_create do
    clothe = Stripe::Product.create(name: name)
    price = Stripe::Price.create(product: clothe, unit_amount: self.price, currency: "eur")
    update(stripe_clothe_id: clothe.id, stripe_price_id: price.id)
  end

  after_update :create_and_asign_new_price, if: :saved_change_to_price?
    def create_and_asign_new_price
      price = Stripe::Price.create(product: self.stripe_clothe_id, unit_amount: self.price, currency: "eur")
      update(stripe_price_id: price.id)
    end
end
