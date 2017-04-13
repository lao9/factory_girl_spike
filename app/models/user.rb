class User < ApplicationRecord
  has_secure_password
  validates :first_name, :last_name, :email, :password, presence: true
  validates :email, uniqueness: true

  has_many :orders

  def full_name
    "#{first_name} #{last_name}"
  end
end
