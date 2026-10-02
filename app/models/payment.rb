class Payment < ApplicationRecord
  has_many :orders, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true
end
