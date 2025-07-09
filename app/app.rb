# frozen_string_literal: true

require_relative 'adapters/inbound/cli_interface'
require_relative 'adapters/outbound/yaml_product_catalog'
require_relative 'models/cart'
require_relative 'models/cart_item'
require_relative 'models/checkout'
require_relative 'models/product'
require_relative 'models/price_rules/price_rule'
require_relative 'models/price_rules/buy_quantity_get_some_free'
require_relative 'models/price_rules/buy_quantity_and_drop_price'

catalog_adapter = YamlProductCatalog.new('app/data/products.yml')
catalog = catalog_adapter.all_products
catalog_indexed = catalog.each_with_object({}) do |product, hash|
  hash[product.code] = product
end

rules = [
  BuyQuantityGetSomeFree.new(product_code: 'GR1', buy_quantity: 1, free_quantity: 1),
  BuyQuantityAndDropPrice.new(product_code: 'SR1', min_quantity_for_discount: 3, new_price: 4.5),
  BuyQuantityAndDropPrice.new(product_code: 'CF1', min_quantity_for_discount: 3, discount: 2 / 3.0)
]

checkout = Checkout.new(rules: rules)

Adapters::CLI.new(checkout: checkout, catalog: catalog_indexed).start
