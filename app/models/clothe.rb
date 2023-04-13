class Clothe < ApplicationRecord
  belongs_to :user

  validates :name, :description, :price, :image, presence: true
end
