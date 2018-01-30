class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :description

  def image
    object.image.url
  end
end
