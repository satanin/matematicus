class Vote < ActiveRecord::Base
  VOTE_UP= 1
  VOTE_DOWN= -1
  belongs_to :user
  belongs_to :question
end
