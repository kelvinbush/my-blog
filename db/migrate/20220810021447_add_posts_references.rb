class AddPostsReferences < ActiveRecord::Migration[7.0]
  def change
    add_reference :likes, :post, foreign_key: { to_table: :posts }, index: true
  end
end
