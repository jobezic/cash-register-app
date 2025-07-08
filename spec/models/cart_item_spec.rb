# frozen_string_literal: true

require 'cart_item'

RSpec.describe CartItem do
  let(:product) { Product.new(code: 'GR1', name: 'Green Tea', price: 3.11) }

  describe '#initialize' do
    it 'assigns product and quantity' do
      item = described_class.new(product: product, quantity: 3)
      expect(item.product).to eq(product)
      expect(item.quantity).to eq(3)
    end

    it 'raises an error if quantity is less than 1' do
      expect do
        described_class.new(product: product, quantity: 0)
      end.to raise_error(ArgumentError, /quantity must be positive/)
    end

    it 'raises an error if quantity is not an integer' do
      expect do
        described_class.new(product: product, quantity: 'two')
      end.to raise_error(ArgumentError)
    end
  end

  describe '#quantity=' do
    it 'increments the quantity of an item' do
      item = described_class.new(product: product, quantity: 1)
      item.quantity += 1

      expect(item.quantity).to eq(2)
    end
  end

  describe '#total' do
    it 'returns product.price * quantity' do
      item = described_class.new(product: product, quantity: 4)
      expect(item.total).to eq(12.44)
    end
  end
end
