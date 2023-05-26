class Customer < ApplicationRecord
  belongs_to :store, optional: true
  has_many :orders
end
