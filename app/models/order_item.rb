class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  before_save :calculate_order_item_total_value
  after_save :update_order

  def calculate_order_item_total_value
    if product && product.price
      self.unitary_value = product.price
      self.total_value = product.price*quantity
    end
  end

  def update_order
    order.calculate_order_total_value
    order.save
  end
end
