class Campaign < ActiveRecord::Base
  belongs_to :user
  has_many :categories, through: :campaign_categories
  has_many :votes

  has_attached_file :featured_image, :styles => { :slider_cropped => "540x304#", :slider_aspect => "540x304>", :crowdreview_cropped => "288x160#", :crowdreview_aspect => "288x160>"}, :default_url => "/images/:style/missing.png" #todo missing image placeholder
  validates_attachment_content_type :featured_image, :content_type => /\Aimage\/.*\Z/
  #reccomended aspect ratio 1.8 (width to height)
  validates_presence_of :campaign_status, :in => [:draft, :under_crowd_review, :under_offline_review, :live, :goal_met, :goal_not_met]
  #todo use enum for campaign statuses
  validates :title, length: {maximum: 60}, :presence => true
  validates :excerpt, length: {maximum: 600}, :presence => true
  validates :summary, length: {maximum: 3000}, :presence => true
  validates :featured_image, :presence => true


  def self.campaigns_under_review
    Campaign.order(created_at: :desc, id: :desc).where(:campaign_status =>  :under_crowd_review)
  end

  def has_user_voted(user)
    if user
      Vote.where(:user_id => user.id, :campaign_id =>  id).size() > 0
    else
      false
    end
  end

end
