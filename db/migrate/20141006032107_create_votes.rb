class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :campaign_id
      t.string :integer
      t.string :user_id
      t.string :integer

      t.timestamps
    end
  end
end
