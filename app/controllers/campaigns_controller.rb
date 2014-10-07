class CampaignsController < ApplicationController
  before_filter :authenticate_user!, except: [:crowdreview_list, :slider_detail]

  def crowdreview_list
    @campaigns = Campaign.campaigns_under_review
  end

  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new(campaign_params)
    @campaign.campaign_status = :under_crowd_review
    if @campaign.save
      redirect_to :root
    else
      flash[:error] = @campaign.errors.empty? ? "Error" : @campaign.errors.full_messages.to_sentence if is_navigational_format?
      render 'new'
    end
  end

  def edit

  end

  def update

  end

  def show

  end

  #called with json datatype
  def toggle_vote
    @campaign = Campaign.find(params[:id])
    if @campaign
      @vote = @campaign.votes.where(:user_id => current_user.id).first
      if @vote
        #delete vote
        @campaign.votes.destroy(@vote)
        @campaign.reload
        render :json => {:campaign_id => @campaign.id, :votes_count => @campaign.votes_count}
      else
        #create vote
        @vote = @campaign.votes.create(:user_id => current_user.id)
        @campaign.reload #this is required to update the votes counter cache. Without a call to reload, the votes_count will return incorrect value.
        if @vote
          render :json => {:campaign_id => @campaign.id, :votes_count => @campaign.votes_count}
        else
          render :json => {:errors => @vote.errors.empty? ? 'Error. Upvote wa not registered. Please try again.' : @vote.errors.full_messages.to_sentence}, status: :internal_server_error
        end
      end
    else
      #campaign not found
      render :json => {:errors => 'Campaign seems to have been removed! Please refresh this page and try again.'}, status: :internal_server_error
    end
  end

  #called by colorbox
  def slider_detail
    @campaign = Campaign.find(params[:id])
    if !@campaign
      flash[:error] = 'Campaign seems to have been removed! Please refresh this page and try again.'
    end
    render :layout => false
  end

  private

  def campaign_params
    accessible = [:title, :excerpt, :summary, :featured_image]
    params.require(:campaign).permit(accessible)
  end

end