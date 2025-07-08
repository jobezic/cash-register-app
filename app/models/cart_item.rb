# frozen_string_literal: true

# Represents an item in the cart, combining a product and its quantity.
class CartItem
  attr_accessor :quantity
  attr_reader :product

  # @param product [Product] the item product
  # @param quantity [Integer] the quantity of the product
  def initialize(product:, quantity:)
    raise ArgumentError, 'quantity must be positive' unless quantity.is_a?(Integer) && quantity >= 1

    @product = product
    @quantity = quantity
  end

  def total
    product.price * quantity
  end
end
