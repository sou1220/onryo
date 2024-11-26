class FavoritesController < ApplicationController
  def create
    @post_favorite = Favorite.new(user_id: current_user.id, post_id: params[:post_id])
    @post_favorite.save
    redirect_to posts_path
  end
  
  def destroy
    @post_favorite = Favorite.find_by(user_id: current_user.id, post_id: params[:post_id])
    if @post_favorite
      @post_favorite.destroy
    else
      flash[:alert] = "お気に入りの削除に失敗しました"
    end
    redirect_to posts_path
  end
end
