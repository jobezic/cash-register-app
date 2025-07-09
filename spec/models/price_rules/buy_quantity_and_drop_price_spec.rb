# frozen_string_literal: true

require 'price_rules/price_rule'
require 'price_rules/buy_quantity_and_drop_price'

RSpec.describe BuyQuantityAndDropPrice do
  let(:min_quantity_for_discount) { 2 }
  let(:product_gr1) { Product.new(code: 'GR1', name: 'Green Tea', price: 3.11) }
  let(:product_sr1) { Product.new(code: 'SR1', name: 'Strawberries', price: 5) }
  let(:product_cf1) { Product.new(code: 'CF1', name: 'Coffee', price: 11.23) }
  let(:cart) { Cart.new }

  context 'with discount strategy' do
    let(:rule) do
      described_class.new(product_code: product_gr1.code, min_quantity_for_discount: 2, discount: 0.5)
    end

    it 'returns 0 if cart is empty' do
      expect(rule.apply(cart)).to eq(0)
    end

    it 'returns 0 if quantity is below threshold' do
      cart.add(product_gr1, 1)
      expect(rule.apply(cart)).to eq(0)
    end

    it 'applies discount if quantity meets threshold' do
      cart.add(product_gr1, 2)
      expect(rule.apply(cart)).to eq(3.11)
    end

    it 'applies discount correctly for more than threshold' do
      cart.add(product_gr1, 5)
      expect(rule.apply(cart)).to eq(3.11 * 5 * 0.5)
    end
  end

  context 'with new price factor strategy' do
    let(:rule) do
      described_class.new(product_code: product_gr1.code, min_quantity_for_discount: 2, new_price: 2)
    end

    it 'returns 0 if cart is empty' do
      expect(rule.apply(cart)).to eq(0)
    end

    it 'returns 0 if quantity is below threshold' do
      cart.add(product_gr1, 1)
      expect(rule.apply(cart)).to eq(0)
    end

    it 'applies discount if quantity meets threshold' do
      cart.add(product_gr1, 2)
      expect(rule.apply(cart)).to eq((3.11 * 2) - 4)
    end
  end

  context 'invalid construction' do
    it 'raises an error if neither new_price nor discount is given' do
      expect do
        described_class.new(product_code: 'GR1', min_quantity_for_discount: 3)
      end.to raise_error(ArgumentError, /Either new_price or discount must be provided/)
    end
  end
end
