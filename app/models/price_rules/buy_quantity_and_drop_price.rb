# frozen_string_literal: true

# Applies a "Buy X, Pay Y" promotion for a specific product.
class BuyQuantityAndDropPrice < PriceRule
  attr_reader :product_code, :min_quantity_for_discount, :new_price, :discount

  def initialize(product_code:, min_quantity_for_discount:, new_price: nil, discount: nil)
    super()
    raise ArgumentError, 'Either new_price or discount must be provided' if new_price.nil? && discount.nil?

    @product_code = product_code
    @min_quantity_for_discount = min_quantity_for_discount
    @new_price = new_price
    @discount = discount
  end

  def apply(cart)
    item = cart.items.find { |i| i.product.code == @product_code }
    return 0 unless item && item.quantity >= @min_quantity_for_discount

    original_total = item.product.price * item.quantity
    discounted_total = calculate_item_discount(item)

    original_total - discounted_total
  end

  private

  def calculate_item_discount(item)
    return @new_price * item.quantity if @new_price

    item.product.price * @discount * item.quantity
  end
end
