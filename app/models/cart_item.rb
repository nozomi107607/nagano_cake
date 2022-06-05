class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  def subtotal
    pp item.with_tax_price
    pp amount
    item.with_tax_price * amount
  end

end
