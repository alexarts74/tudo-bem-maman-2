class Clothe < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :name, :description, :price, presence: true
end
