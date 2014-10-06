class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :title
      t.text :brief
      t.text :excerpt
      t.text :summary
      t.integer :user_id

      t.timestamps
    end
  end
end
