class AddAnsweredAtToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :answered_at, :datetime
  end
end
