class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, numericality: { only_integer: true, greater_than: 0 }

  before_validation :copy_values_from_product
  after_save :refresh_order_total
  after_destroy :refresh_order_total

  private

  # O preço vem do produto no momento da compra: o pedido não pode mudar de
  # valor se o produto for reajustado depois.
  def copy_values_from_product
    return if product.nil? || quantity.nil?

    self.unitary_value = product.price
    self.total_value = product.price * quantity if product.price
  end

  def refresh_order_total
    order.recalculate_total_value!
  end
end
