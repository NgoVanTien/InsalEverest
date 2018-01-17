class Order < ApplicationRecord
  belongs_to :table

  has_many :product_orders, dependent: :destroy

  accepts_nested_attributes_for :product_orders, allow_destroy: true, reject_if: proc{|attr| attr[:quantity] <= 0}
end
