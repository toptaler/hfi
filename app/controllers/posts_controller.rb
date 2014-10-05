class PostsController < ApplicationController

  def vote
    post = Post.find(params[:id])
    post.update(votes: post.votes.to_i + 1)
    render json: {post_id: post.id, total_votes: post.votes.to_s}
  end

  def detail
    @post = Post.find(params[:id])
    render partial: 'post_detail', layout: false
  end

end
