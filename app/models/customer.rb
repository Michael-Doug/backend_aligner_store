class Customer < ApplicationRecord
  belongs_to :store
  has_many :orders, dependent: :restrict_with_error

  validates :name, presence: true
  validates :cpf, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, allow_blank: true }
end
