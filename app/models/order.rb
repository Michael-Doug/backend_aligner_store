class Order < ApplicationRecord
  belongs_to :store
  belongs_to :payment
  belongs_to :customer
  has_many :order_items, dependent: :destroy

  before_validation :reset_total_value, on: :create

  def recalculate_total_value!
    update_column(:total_value, order_items.sum(:total_value) || 0)
  end

  private

  def reset_total_value
    self.total_value = 0
  end
end
