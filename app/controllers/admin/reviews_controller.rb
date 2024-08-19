class Admin::ReviewsController < ApplicationController
  def destroy
    @post = Post.find(params[:id])
    @post.update(star: nil)
    redirect_to admin_dashboards_path, notice: "レビューを削除しました"
  end
end
