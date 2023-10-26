class AddIndexToPosts < ActiveRecord::Migration[7.1]
  def change
    unless index_exists?(:posts, :author_id)
      add_index :posts, :author_id
    end
  end
end
