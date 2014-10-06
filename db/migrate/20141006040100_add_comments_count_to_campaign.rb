class AddCommentsCountToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :comments_count, :integer
  end
end
