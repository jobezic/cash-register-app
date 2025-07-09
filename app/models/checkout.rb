# frozen_string_literal: true

# The Checkout class is responsible for coordinating the cart and
# applying any pricing or discount rules that implement the PriceRule interface.
# It returns the final total after all applicable discounts.
class Checkout
  def initialize(rules: [])
    raise ArgumentError, 'Provide valid rules' if rules.any? { |r| !r.respond_to?(:apply) }

    @rules = rules
  end

  def total(cart)
    base_total = cart.items.sum(&:total)
    discount = @rules.sum { |rule| rule.apply(cart) }
    base_total - discount
  end
end
