class User < ApplicationRecord
  has_many :posts ,dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
         validates :email, presence: true
         validates :name, presence: true
         validates :password,presence: true, length: { minimum: 6 }, if: -> { password.present? }
         validates :password_confirmation,presence: true, length: { minimum: 6 }, if: -> { password_confirmation.present? }
       
         
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
        
        # 投稿検索機能
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
