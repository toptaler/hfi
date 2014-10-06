class CreateCampaignCategories < ActiveRecord::Migration
  def change
    create_table :campaign_categories do |t|
      t.integer :campaign_id
      t.integer :category_id

      t.timestamps
    end
  end
end
