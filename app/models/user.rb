class User < ApplicationRecord
  has_secure_password
  validates :first_name, :last_name, :password_digest, :email, presence: true
  validates :email, uniqueness: true

  has_many :orders
  has_many :reviews

  enum role: %w(default admin)

  def full_name
    "#{first_name} #{last_name}"
  end

  def empty_address?
    street.nil? || city.nil? || state.nil? || zipcode.nil?
  end

  def city_state_zip
    "#{city}, #{state} #{zipcode}"
  end
end
