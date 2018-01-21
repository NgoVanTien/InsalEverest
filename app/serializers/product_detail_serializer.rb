class ProductDetailSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :description, :unit_name, :discount

  def unit_name
    object.unit_name
  end

  def discount
    discount = object.discounts&.date_current
    discount.blank? ? 0 : discount.percent
  end
end
