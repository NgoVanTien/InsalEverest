class Api::V1::ProductOrdersController < Api::V1::BaseController
  def index
    render_json_data({data: load_products, message: {success: I18n.t("messages.list_product")}}, 201)
  end

  private

  def load_products
    Category.all.map{|category| response_data(ProductsSerializer, category)}
  end
end
