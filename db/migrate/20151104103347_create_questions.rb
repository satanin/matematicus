class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :title
      t.text :body
      t.integer :times_viewed, default: 0
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
