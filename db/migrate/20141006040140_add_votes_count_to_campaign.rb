class AddVotesCountToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :votes_count, :integer
  end
end
