class SearchesController < ApplicationController
  
  def search
    @model = params[:model]
    @word = params[:word]
    if @model == "User"
      @users = User.looks(params[:search], params[:word])
    elsif @model == "Post"
      @posts = Post.looks(params[:search], params[:word])
    end
  end
end
