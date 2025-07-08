# frozen_string_literal: true

# Represents a cart containing some cart items.
class Cart
  attr_reader :items

  def initialize
    @items = []
  end

  def add(product, quantity = 1)
    item = @items.find { |i| i.product.code == product.code }
    if item
      item.quantity += quantity
    else
      @items << CartItem.new(product: product, quantity: quantity)
    end
  end
end
