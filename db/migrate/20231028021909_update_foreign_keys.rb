class UpdateForeignKeys < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :comments, :users
    remove_foreign_key :comments, :users, column: :post_id
    add_foreign_key :comments, :posts
    add_foreign_key :comments, :users

    remove_foreign_key :likes, :users
    remove_foreign_key :likes, :users, column: :post_id
    add_foreign_key :likes, :posts
    add_foreign_key :likes, :users

    remove_foreign_key :posts, :users, column: :author_id
    add_foreign_key :posts, :users, column: :author_id
  end
end
