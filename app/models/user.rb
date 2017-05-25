class User < ApplicationRecord
  has_secure_password
  validates :first_name, :last_name, :role, :password_digest, :email, presence: true
  validates :email, uniqueness: true

  has_many :orders
  has_many :reviews

  enum role: %w(default admin)

  def full_name
    "#{first_name} #{last_name}"
  end

end
