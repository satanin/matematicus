class Vote < ActiveRecord::Base
  VOTE_UP= 1
  VOTE_DOWN= -1
  belongs_to :user
  belongs_to :question
  belongs_to :answer
  validates :user_id, uniqueness: {scope: :question_id}
  validates :user_id, uniqueness: {scope: :answer_id}
end
