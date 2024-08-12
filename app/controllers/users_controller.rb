class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:update, :destroy, :edit, :show]
  before_action :ensure_guest_user, only: [:edit]
  
  def mypage
    @posts = Post.all
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to mypage_path
    end
  end

  def show
    @user = current_user
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
  
  def ensure_guest_user
    user = User.find(params[:id])
    if user.guest_user?
      redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集画面へ推移できません"
    end
  end
end