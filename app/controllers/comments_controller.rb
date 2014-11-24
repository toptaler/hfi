class CommentsController < ApplicationController
  before_filter :authenticate_user!, except: [:show]


  def new
  end

  def create
    @comment = Comment.new comment_params
    @comment.campaign_id = params[:campaign_id]
    @comment.user_id = current_user.id
    @comment.save
    @comment.campaign.reload #to reload the comments_count that is then used by the display
    respond_to do |format|
      format.js
    end
  end

  def edit

  end

  def update

  end

  def show

  end

  def destroy
    @comment = Comment.where(id: params[:id]).first
    if @comment
      @comment.destroy
    end
    respond_to do |format|
      format.js
    end
  end

  def comment_params
    accessible = [:content, :campaign_id]
    params.require(:comment).permit(accessible)
  end

end