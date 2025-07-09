# frozen_string_literal: true

require_relative 'adapters/inbound/cli_interface'
require_relative 'models/cart'
require_relative 'models/cart_item'
require_relative 'models/checkout'
require_relative 'models/product'
require_relative 'models/price_rules/price_rule'
require_relative 'models/price_rules/buy_quantity_get_some_free'
require_relative 'models/price_rules/buy_quantity_and_drop_price'

catalog = {
  'GR1' => Product.new(code: 'GR1', name: 'Green Tea', price: 3.11),
  'SR1' => Product.new(code: 'SR1', name: 'Strawberries', price: 5),
  'CF1' => Product.new(code: 'CF1', name: 'Coffee', price: 11.23)
}

rules = [
  BuyQuantityGetSomeFree.new(product_code: 'GR1', buy_quantity: 1, free_quantity: 1),
  BuyQuantityAndDropPrice.new(product_code: 'SR1', min_quantity_for_discount: 3, new_price: 4.5),
  BuyQuantityAndDropPrice.new(product_code: 'CF1', min_quantity_for_discount: 3, discount: 2 / 3.0)
]

checkout = Checkout.new(rules: rules)

Adapters::CLI.new(checkout: checkout, catalog: catalog).start
