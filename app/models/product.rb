class Product < ApplicationRecord
  belongs_to :unit
  belongs_to :category

  has_many :product_orders, dependent: :destroy
  has_many :orders, through: :product_orders
  has_many :discounts, dependent: :destroy

  validates :name, presence: true
  validates :unit_id, presence: true
  validates :category_id, presence: true

  mount_uploader :image, ImageUploader

  delegate :name, to: :unit, prefix: true, allow_nil: true
end
