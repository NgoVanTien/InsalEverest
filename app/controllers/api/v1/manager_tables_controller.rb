class Api::V1::ManagerTablesController < Api::V1::BaseController

  def index
    case params["type"]
    when "Tables", nil
      render_json_data({data: tables_state}, 201)
    when "Positions"
      render_json_data({data: positions_info}, 201)
    else
      render_json_data({data: {}, message: {warning: I18n.t("messages.not_found")}}, 401)
    end
  end

  private

  def tables_state
    {
      empty: Table.all.empty.count,
      active: Table.where(state: %i(pending ordered)).count
    }
  end

  def positions_info
    Position.all.map do |position|
      {id: position.id, name: position.name, number_table: position.tables.count}
    end
  end
end
