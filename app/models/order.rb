class Order < ApplicationRecord
  belongs_to :store
  belongs_to :payment
  belongs_to :customer
  has_many :order_items, dependent: :destroy

  before_save :calculate_order_total_value

  def calculate_order_total_value
    puts "calcular o valor total deu certo?"
    self.total_value = order_items.sum(&:total_value)
  end

end
