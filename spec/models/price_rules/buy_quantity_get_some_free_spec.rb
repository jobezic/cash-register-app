# frozen_string_literal: true

require 'price_rules/price_rule'
require 'price_rules/buy_quantity_get_some_free'

RSpec.describe BuyQuantityGetSomeFree do
  let(:product_gr1) { Product.new(code: 'GR1', name: 'Green Tea', price: 3.11) }
  let(:cart) { Cart.new }

  context 'buy 1 get 1 free' do
    let(:rule) { described_class.new(product_code: 'GR1', buy_quantity: 1, free_quantity: 1) }

    it 'gives 1 free for every 2' do
      cart.add(product_gr1, 2)
      expect(rule.apply(cart)).to eq(3.11)
    end

    it 'applies no discount for 1 item' do
      cart.add(product_gr1, 1)
      expect(rule.apply(cart)).to eq(0)
    end
  end

  context 'buy 2 get 1 free' do
    let(:rule) { described_class.new(product_code: 'GR1', buy_quantity: 2, free_quantity: 1) }

    it 'gives 1 free for every 3' do
      cart.add(product_gr1, 6)
      expect(rule.apply(cart)).to eq(6.22)
    end

    it 'gives 1 free for 3 items, 0 for 2' do
      cart.add(product_gr1, 3)
      expect(rule.apply(cart)).to eq(3.11)
    end

    it 'gives no discount if less than 3' do
      cart.add(product_gr1, 2)
      expect(rule.apply(cart)).to eq(0)
    end
  end
end
