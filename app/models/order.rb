class Order < ApplicationRecord
  belongs_to :table, required: true

  has_many :product_orders, dependent: :destroy
  has_many :products, through: :product_orders

  accepts_nested_attributes_for :product_orders, allow_destroy: true, reject_if: proc{|attr| attr[:quantity] <= 0}

  validates_with ProductOrderValidator

  enum state: {unpaid: 0, paid: 1}
end
