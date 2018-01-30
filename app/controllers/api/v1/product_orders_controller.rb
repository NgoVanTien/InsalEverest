class Api::V1::ProductOrdersController < Api::V1::BaseController
  before_action :load_category, only: :index, if: proc{params[:category_id].present?}

  def index
    render_json_data({data: load_products, message: {success: I18n.t("messages.list_product")}}, 201)
  end

  private

  def load_category
    @category = Category.find_by id: params[:category_id]
    return if @category.present?
    render_json_error({"category": I18n.t("activerecord.errors.models.category.attributes.category.not_found")}, 401)
  end

  def load_products
    @category ||= Category.first
    {category: CategorySerializer.new(@category), products: list_product(@category)}
  end

  def list_product category
    category.products.map{|product| ProductDetailSerializer.new(product)}
  end
end
