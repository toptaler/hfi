class AddCampaignIdToComment < ActiveRecord::Migration
  def change
    add_column :comments, :campaign_id, :integer
  end
end
