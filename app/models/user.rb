class User < ApplicationRecord
  has_secure_password
  has_one :address, as: :addressable,	dependent: :destroy

  accepts_nested_attributes_for :address

  validates :email, uniqueness: true
end
