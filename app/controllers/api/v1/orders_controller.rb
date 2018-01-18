class Api::V1::OrdersController < Api::V1::BaseController
  before_action :load_order, only: [:update, :show]

  def create
    order = Order.new order_params
    if order.save
      render_json_data(
        {
          data: response_data(OrderSerializer, order),
          message: {success: I18n.t("messages.create_success")}
        },
        201
      )
    else
      render_json_error order.errors, 422
    end
  end

  def update
    if @order.update_attributes order_params
      render_json_data(
        {
          data: response_data(OrderSerializer, @order),
          message: {success: I18n.t("messages.update_success")}
        },
        201
      )
    else
      render_json_error @order.errors, 422
    end
  end

  def show
    render_json_data({data: response_data(OrderSerializer, @order)}, 201)
  end

  def order_params
    params.permit :id, :table_id, :state,
      product_orders_attributes: [:id, :product_id, :quantity, :_destroy]
  end

  private

  def load_order
    @order = Order.find_by id: params[:id]
    return if @order.present?
    render_json_error({"order": I18n.t("activerecord.errors.models.order.attributes.id.not_found")}, 422)
  end
end
