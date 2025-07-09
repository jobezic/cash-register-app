# frozen_string_literal: true

require 'yaml'
require_relative '../../ports/outbound/product_catalog'
require_relative '../../models/product'

# Adapter that implements the ProductCatalog port.
#
# It loads products from a YAML file and converts them into Product objects.
# Used to inject product data into the core application from a static source.
#
class YamlProductCatalog < ProductCatalog
  def initialize(file_path)
    super()
    @file_path = file_path
  end

  def all_products
    YAML.load_file(@file_path).map do |row|
      Product.new(code: row['code'], name: row['name'], price: row['price'].to_f)
    end
  end
end
