# frozen_string_literal: true

# Represents the interface for a price rule.
class PriceRule
  def apply(cart)
    raise NotImplementedError
  end
end
