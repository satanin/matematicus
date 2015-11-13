class AddAnswersToVotes < ActiveRecord::Migration
  def change
    add_reference :votes, :answer, index: true, foreign_key: true
  end
end
