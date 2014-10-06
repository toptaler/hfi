class AddVotesTable < ActiveRecord::Migration
  def up
    create_table :votes do |t|
      t.integer :campaign_id
      t.integer :user_id
      t.timestamps
      end
  end

  def down
    drop_table :votes
  end
end
