class Store < ApplicationRecord
  has_many :sellers
  has_many :orders
  has_many :customers
  has_many :products
end
