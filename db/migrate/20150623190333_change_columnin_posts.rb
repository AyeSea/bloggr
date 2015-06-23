class ChangeColumninPosts < ActiveRecord::Migration
  def change
  	remove_column :posts, :comment
  	add_column :posts, :content, :text
  end
end
