class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
    	t.string :title
    	t.string :body
      t.timestamps
    end
  end
end
