class TableOrderSerializer < ActiveModel::Serializer
  attributes :id, :name, :state, :position_id
end
