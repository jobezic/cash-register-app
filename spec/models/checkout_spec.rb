# frozen_string_literal: true

require 'checkout'

RSpec.describe Checkout do
  let(:product_gr1) { Product.new(code: 'GR1', name: 'Green Tea', price: 3.5) }
  let(:product_sr1) { Product.new(code: 'SR1', name: 'Strawberries', price: 5) }

  let(:cart) { Cart.new }

  context 'without any rules' do
    let(:checkout) { Checkout.new }

    it 'returns 0 for an empty cart' do
      expect(checkout.total(cart)).to eq(0.0)
    end

    it 'returns sum of item totals' do
      cart.add(product_gr1, 2)
      cart.add(product_sr1, 1)

      expect(checkout.total(cart)).to eq(12)
    end
  end

  context 'with a pricing rule' do
    let(:rule) do
      # Fake rule that returns a fixed €5 discount
      double('PriceRule', apply: 5)
    end

    let(:checkout) { Checkout.new(rules: [rule]) }

    it 'applies discount from rule' do
      cart.add(product_gr1, 2)
      expect(checkout.total(cart)).to eq(2)
    end
  end

  context 'with multiple rules' do
    let(:rule1) { double('PriceRule1', apply: 3) }
    let(:rule2) { double('PriceRule2', apply: 2) }
    let(:checkout) { Checkout.new(rules: [rule1, rule2]) }

    it 'applies all discounts' do
      cart.add(product_sr1, 3)
      expect(checkout.total(cart)).to eq(10)
    end
  end
end
