class PostsController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  
  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
    @posts = Post.all.page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿に成功しました"
      redirect_to post_path(@post.id)
    else
      flash[:error] = "投稿に失敗しました"
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
    if @post.update(post_params)
    redirect_to post_path(@post.id)
    else
      flash[:error] = "更新に失敗しました"
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:error] = "投稿を削除しました"
    redirect_to mypage_path
  end
  
  
  
  private
  
  def post_params
    params.require(:post).permit(:image, :title, :body, :star, :tag)
  end
  
  def is_matching_login_user
    post = Post.find(params[:id])
    unless post.user_id == current_user.id
      redirect_to posts_path
    end
  end
end
