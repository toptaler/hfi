class Vote < ActiveRecord::Base
  belongs_to :campaign, :counter_cache => :votes_count
  belongs_to :user


end
