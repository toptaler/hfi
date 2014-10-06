class Category < ActiveRecord::Base
  has_many :campaigns, through: :campaign_categories
end
