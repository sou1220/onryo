class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  
  def mypage
    @posts = Post.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
  end

  def update
    @user = User.find(params[:id])
    @user.id = current_user.id
    if @user.update(user_params)
      redirect_to mypage_path
    else
      flash[:alert] = "更新に失敗しました"
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    user.id = current_user.id
    user.destroy
    flash[:notice] = "アカウントを削除しました"
    redirect_to new_user_registration_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to posts_path
    end
  end
end
