class SearchesController < ApplicationController
  
  def search
    @model = params[:model]
    @word = params[:word]
    if @model == "user"
      @users = User.looks(params[:search], params[:word])
    else
      @posts = Post.looks(params[:search], params[:word])
    end
  end
end
