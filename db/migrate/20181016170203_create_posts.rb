class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :title
      t.text   :content
      t.string :image
      t.boolean :draft, default: false
      t.string :permission, default: "all"
      t.integer :replied_count, default: 0
      t.integer :viewed_count, default: 0
      t.timestamps
    end
  end
end
