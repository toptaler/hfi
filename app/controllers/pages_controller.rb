class PagesController < ApplicationController
  def home
    @posts = Post.all.order(votes: :desc)
  end
end
