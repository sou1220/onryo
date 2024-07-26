class User < ApplicationRecord
  has_many :post ,dependent: :destroy
  has_many :comments, dependent: :destroy
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
         validates :email, presence: true
         validates :password, presence: true
         validates :name, presence: true
         validates :password_confirmation, presence: true
         
          def self.looks(search, word)
            if search == "perfect"
              @user = User.where("name LIKE?", "#{word}")
            elsif search == "forward"
              @user = User.where("name LIKE?","#{word}%")
            elsif search == "backward"
              @user = User.where("name LIKE?","%#{word}")
            elsif search == "partial"
              @user = User.where("name LIKE?","%#{word}%")
            else
              @user = User.all
            end
          end
end
