class Product < ApplicationRecord
  belongs_to :store
  has_many :order_items
end
