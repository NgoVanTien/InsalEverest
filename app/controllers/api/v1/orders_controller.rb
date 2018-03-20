class Api::V1::OrdersController < Api::V1::BaseController
  before_action :load_order, only: [:update, :show]
  before_action :changed_state_table, only: :update

  def create
    order = Order.new order_params
    table = Table.find_by(id: params[:table_id])&.update state: :pending
    render_json_error({"table": I18n.t("messages.not_found", name: I18n.t("forders.table"))}, 401) unless table
    if order.save &&
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
    render_json_error({"order": I18n.t("activerecord.errors.models.order.attributes.id.not_found")}, 401)
  end

  def changed_state_table
    table = Table.find_by id: params[:table_id]
    table_ids = @order.add_table_ids
    if table.present?
      table_ids << table.id
      UpdateTable.new.changed_state table_ids, :pending
    else
      render_json_error({"table": I18n.t("messages.not_found", name: I18n.t("forders.table"))}, 401)
    end
  end
end
