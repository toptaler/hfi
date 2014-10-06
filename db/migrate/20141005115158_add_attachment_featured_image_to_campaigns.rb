class AddAttachmentFeaturedImageToCampaigns < ActiveRecord::Migration
  def self.up
    change_table :campaigns do |t|
      t.attachment :featured_image
    end
  end

  def self.down
    remove_attachment :campaigns, :featured_image
  end
end
