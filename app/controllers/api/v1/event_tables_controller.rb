class Api::V1::EventTablesController < Api::V1::BaseController
  def index
    case params[:status]
    when "merge"
      # load_order, load_table errors not render 
      order_old = load_order eval(params[:from])[:order_id]
      table_old = load_table eval(params[:from])[:table_id]
      order = load_order eval(params[:to])[:order_id]
      table = load_table eval(params[:to])[:table_id]
      if merge_table order_old, table_old, order, table
        render_json_data(
          {
            data: {},
            message: {warning: I18n.t("messages.merge_success", name: I18n.t("forders.table"))}
          }, 200
        )
      else
        render_json_error({"table": I18n.t("messages.merge_fail")}, 422)
      end
    when "change"
      table = load_table params[:table_id]
      order = load_order params[:order_id]
      if change_table(table, order)
        render_json_data(
          {
            data: {},
            message: {warning: I18n.t("messages.change_success", name: I18n.t("forders.table"))}
          }, 200
        )
      else
        render_json_error({"table": I18n.t("messages.change_fail")}, 422)
      end
    end
  end

  private

  def load_table id
    table = Table.find_by id: id
    return table if table.present?
    render_json_error({"table": I18n.t("activerecord.errors.models.table.attributes.table.not_found")}, 401)
  end

  def load_order id
    order = Order.find_by id: id
    return order if order.present?
    render_json_error({"order": I18n.t("activerecord.errors.models.order.attributes.id.not_found")}, 401)
  end

  def merge_table order_old, table_old, order, table
    return false if table.is_empty? || table_old.is_empty?
    order.product_order_ids += order_old.product_order_ids
    order_old.delete
    state = (table.pending? || table_old.pending?) ? :pending : :ordered
    UpdateTable.new.changed_state [table.id, table_old.id], state
  end

  def change_table table, order
    return false unless !table.is_empty?
    order.table.update state: :is_empty
    order.update table_id: table.id
    table.update state: :pending
  end
end
