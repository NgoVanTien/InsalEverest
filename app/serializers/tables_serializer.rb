class TablesSerializer < ActiveModel::Serializer
  attributes :id, :name, :state, :position_id
  attribute :order_id{object.orders.unpaid.first&.id}
end
