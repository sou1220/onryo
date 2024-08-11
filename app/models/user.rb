class User < ApplicationRecord
  has_many :posts ,dependent: :destroy
  has_many :comments, dependent: :destroy
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
         validates :email, presence: true
         validates :name, presence: true
         
         GUEST_USER_EMAIL = "guest@example.com"
         
        def self.guest
          find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
            user.password = SecureRandom.urlsafe_base64
            user.name = "guestuser"
          end
        end
         
         def guest_user?
           email == GUEST_USER_EMAIL
         end
         
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
