# frozen_string_literal: true

require 'cart'

RSpec.describe Cart do
  let(:product_gr1) { Product.new(code: 'GR1', name: 'Green Tea', price: 3.11) }
  let(:product_sr1) { Product.new(code: 'SR1', name: 'Strawberries', price: 5) }

  describe '#initialize' do
    it 'starts with an empty items list' do
      cart = Cart.new
      expect(cart.items).to be_empty
    end
  end

  describe '#add' do
    it 'adds a new CartItem to the cart' do
      cart = Cart.new
      cart.add(product_gr1, 2)

      expect(cart.items.size).to eq(1)
      expect(cart.items.first).to be_a(CartItem)
      expect(cart.items.first.product).to eq(product_gr1)
      expect(cart.items.first.quantity).to eq(2)
    end

    it 'increments quantity if product already exists in cart' do
      cart = Cart.new
      cart.add(product_gr1, 1)
      cart.add(product_gr1, 3)

      expect(cart.items.size).to eq(1)
      expect(cart.items.first.quantity).to eq(4)
    end

    it 'adds multiple different products' do
      cart = Cart.new
      cart.add(product_gr1, 1)
      cart.add(product_sr1, 2)

      expect(cart.items.size).to eq(2)
      expect(cart.items.map(&:product)).to contain_exactly(product_gr1, product_sr1)
    end
  end
end
