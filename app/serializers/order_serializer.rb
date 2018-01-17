class OrderSerializer < ActiveModel::Serializer
  attributes :id, :table_id, :state

  has_many :product_orders
end
