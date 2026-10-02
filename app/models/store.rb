class Store < ApplicationRecord
  has_many :sellers, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :customers, dependent: :restrict_with_error
  has_many :orders, dependent: :restrict_with_error

  validates :name, presence: true
end
