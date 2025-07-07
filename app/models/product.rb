# frozen_string_literal: true

# Represents a product with a unique code, name, and price.
class Product
  attr_reader :code, :name, :price

  # @param code [String] unique identifier
  # @param name [String] display name
  # @param price [Float] price in main units (e.g. 5.99)
  def initialize(code:, name:, price:)
    raise ArgumentError, 'code is required' if code.nil? || code.empty?
    raise ArgumentError, 'name is required' if name.nil? || name.empty?
    raise ArgumentError, 'price must be a positive number' unless price.is_a?(Numeric) && price >= 0

    @code  = code
    @name  = name
    @price = price
    freeze
  end
end
