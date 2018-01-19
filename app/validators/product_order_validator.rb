class ProductOrderValidator < ActiveModel::Validator
  def validate record
    validate_products record
  end

  private
  def validate_products record
    record.product_orders.each do |product_order|
      next if Product.find_by id: product_order.product_id
      return record.errors.add :product_orders, :not_found
    end
  end
end
