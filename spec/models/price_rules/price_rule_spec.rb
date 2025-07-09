# frozen_string_literal: true

require 'price_rules/price_rule'

RSpec.describe PriceRule do
  describe '#apply' do
    let(:cart) { Cart.new }

    it 'raises NotImplementedError' do
      expect { described_class.new.apply(cart) }.to raise_error 'NotImplementedError'
    end
  end
end
