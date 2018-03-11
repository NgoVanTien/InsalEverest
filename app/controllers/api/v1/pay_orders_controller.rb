class Api::V1::PayOrdersController < Api::V1::BaseController
  before_action :load_order, only: :create

  def create
    if Payment.new({total: params[:total], order: @order}).order &&
        UpdateTable.new.changed_state((@order.add_table_ids << table.id), :is_empty)
      render_json_data({message: {success: I18n.t("messages.payment_success")}}, 201)
    else
      render_json_data({message: {warning: I18n.t("messages.payment_fail")}}, 422)
    end
  end

  private

  def load_order
    @order = Order.find_by id: params[:order_id]
    return if @order.present?
    render_json_error({"order": I18n.t("activerecord.errors.models.order.attributes.id.not_found")}, 401)
  end
end
