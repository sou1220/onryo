class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :title, presence: true
  validates :body, presence: true
  validates :tag, presence: true
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
  
  # 投稿検索機能
  def self.looks(search, word)
    if search == "perfect"
      @post = Post.where("title LIKE?", "#{word}")
    elsif search == "forward"
      @post = Post.where("title LIKE?","#{word}%")
    elsif search == "backward"
      @post = Post.where("title LIKE?","%#{word}")
    elsif search == "partial"
      @post = Post.where("title LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end
  
  # いいね機能
    def favorited_by?(user)
      favorites.where(user_id: user.id).exists?
    end
end
