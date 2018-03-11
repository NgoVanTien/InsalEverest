class UpdateTable
  include Base

  def changed_state table_ids, state
    valid = true
    Table.where(id: table_ids).update_all state: state
  rescue Exception => e
    valid = false
  ensure
    valid
  end
end
