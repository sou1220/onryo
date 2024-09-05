class TagsController < ApplicationController
  def tag_search
  @model = Post
  @word = params[:word]
  @search_word = params[:search_word]

  if @word.present?
    @posts = Post.where(tag: @word)
  elsif @search_word.present?
    @posts = Post.where("tag LIKE ?", "%#{@search_word}%")
  else
    @posts = Post.none
  end
  render "tag_search"
  end
end
