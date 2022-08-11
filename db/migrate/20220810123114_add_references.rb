class AddReferences < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :author, foreign_key: { to_table: :users }, index: true
    add_reference :comments, :author, foreign_key: { to_table: :users }, index: true
    add_reference :likes, :author, foreign_key: { to_table: :users }, index: true
    add_reference :likes, :post, foreign_key: { to_table: :posts }, index: true
    add_reference :comments, :post, foreign_key: { to_table: :posts }, index: true
  end
end
