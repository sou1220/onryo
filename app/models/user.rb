class User < ApplicationRecord
  has_many :post ,dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
         validates :email, presence: true
         validates :password, presence: true
         validates :name, presence: true
         validates :password_confirmation, presence: true
end
