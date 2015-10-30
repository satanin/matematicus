class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :title
      t.text :body
      t.integer :times_viewed, default: 0
      t.string :type
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
