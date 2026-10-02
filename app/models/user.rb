class User < ApplicationRecord
  has_secure_password

  belongs_to :customer, optional: true

  enum role: { customer: 0, admin: 1 }, _default: :customer

  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, if: -> { password.present? }

  before_validation { self.email = email.strip.downcase if email.present? }
end
