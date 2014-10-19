class CampaignsController < ApplicationController
  before_filter :authenticate_user!, except: [:crowdreview_list, :slider_detail]

  def crowdreview_list
    @campaigns = Campaign.campaigns_under_review
  end

  def user_campaigns
    #the html format goes to user_campaigns.html.erb which displays the page, but not the table with the campaigns yet
    #the page makes an ajax request i.e. the json format request
    #that is when we return the campaigns that then get displayed
    #we could have just loaded them at first go with an approach like this: http://www.datatables.net/examples/data_sources/js_array.html
    #but I want with the  ajax approach http://www.datatables.net/examples/ajax/objects.html
    #because it felt more elegant
    respond_to do |format|
      format.html  {
        # user_campaigns.html.erb
        @campaigns = Campaign.where(user_id: current_user.id)
        render
      }
      format.json  { render :json => Campaign.where(user_id: current_user.id)}
    end

  end

  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = current_user.campaigns.build(campaign_params)
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

  def destroy
    @campaign = Campaign.where(id: params[:id]).first
    if @campaign
      @campaign.destroy
    end
    respond_to do |format|
      format.html { redirect_to :user_campaigns }
      format.json {
        if @campaign && !@campaign.errors.empty?
          render :json => {errors: @campaign.errors.full_messages.to_sentence}, :status => :internal_server_error
        else
          render :json => {:campaign_id => @campaign.id}
        end

      }
    end
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