class OrderSerializer < ActiveModel::Serializer
  attributes :id, :table_id, :state, :time_in, :time_out

  has_many :product_orders, serializer: ProductOrderSerializer

  def time_in
    I18n.l object.created_at, format: :full_datetime
  end

  def time_out
    I18n.l object.updated_at, format: :full_datetime
  end
end
