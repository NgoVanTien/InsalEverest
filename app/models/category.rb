class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name, presence: true

  mount_uploader :image, ImageUploader
end
