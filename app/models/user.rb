class User < ApplicationRecord
  has_secure_password
  validates :first_name, :last_name, :password_digest, :email, presence: true
  validates :email, uniqueness: true

  has_many :orders

  enum role: %w(default admin)

  def full_name
    "#{first_name} #{last_name}"
  end
end
