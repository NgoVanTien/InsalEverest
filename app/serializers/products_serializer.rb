class ProductsSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :description
  attribute :image{object.image.url}

  has_many :products, serializer: ProductDetailSerializer
end
