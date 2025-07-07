# frozen_string_literal: true

require 'product'

RSpec.describe Product do
  subject(:product) { described_class.new(code: 'GR1', name: 'Green Tea', price: 3.11) }

  describe '#initialize' do
    it 'freezes the object (immutability)' do
      expect(product.frozen?).to be true
    end

    context 'when attributes are valid' do
      it { is_expected.to have_attributes(code: 'GR1', name: 'Green Tea', price: 3.11) }
    end

    context 'when code is blank' do
      it 'raises ArgumentError' do
        expect do
          described_class.new(code: '', name: 'Green Tea', price: 5.00)
        end.to raise_error(ArgumentError, /code is required/)
      end
    end

    context 'when name is blank' do
      it 'raises ArgumentError' do
        expect do
          described_class.new(code: 'GR1', name: nil, price: 5.00)
        end.to raise_error(ArgumentError, /name is required/)
      end
    end

    context 'when price is negative' do
      it 'raises ArgumentError' do
        expect do
          described_class.new(code: 'GR1', name: 'Green Tea', price: -1)
        end.to raise_error(ArgumentError, /price must be a positive number/)
      end
    end
  end
end
