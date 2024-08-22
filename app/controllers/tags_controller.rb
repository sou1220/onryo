class TagsController < ApplicationController
  def tag_search
    @model = Post
    @word = params[:word]
    @posts = Post.where(tag: @word)
    render "tag_search"
  end
end
