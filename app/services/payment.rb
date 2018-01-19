class Payment
  include Base

  def initialize *args
    args = args.extract_options!
    @order = args[:order]
    @total = args[:total]
  end

  def order
    total = @order.product_orders.reduce(0.0) do |sum, product_order|
      product = product_order.product
      discount = product.discounts&.date_current
      price = discount.present? ? (product.price - (product.price * (discount.last.percent / 100))) : product.price
      sum += price * product_order.quantity
    end
    @total == total ? @order.update(total: @total, state: :paid) : false
  end
end
