class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :campaign, :counter_cache => :comments_count
  belongs_to :user
end
