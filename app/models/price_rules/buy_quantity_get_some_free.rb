# frozen_string_literal: true

# Applies a "Buy X, Get Y Free" promotion for a specific product.
class BuyQuantityGetSomeFree < PriceRule
  attr_reader :product_code, :buy_quantity, :free_quantity

  def initialize(product_code:, buy_quantity:, free_quantity:)
    super()
    raise ArgumentError, 'buy_quantity must be > 0' if buy_quantity < 1
    raise ArgumentError, 'free_quantity must be >= 1' if free_quantity < 1

    @product_code = product_code
    @buy_quantity = buy_quantity
    @free_quantity = free_quantity
  end

  def apply(cart)
    item = cart.items.find { |i| i.product.code == @product_code }
    return 0 unless item && item.quantity >= @buy_quantity

    set_size = @buy_quantity + @free_quantity
    sets_applied = item.quantity / set_size
    discount_units = sets_applied * @free_quantity

    discount_units * item.product.price
  end
end
