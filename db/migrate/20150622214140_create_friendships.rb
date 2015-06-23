class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
    	t.integer :accepter_id
    	t.integer :requester_id
    	t.boolean :accepted, default: false
      t.timestamps null: false
    end
  end
end
