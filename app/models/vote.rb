class Vote < ActiveRecord::Base
  VOTE_UP= 1
  VOTE_DOWN= -1
  belongs_to :user
  belongs_to :question
  belongs_to :answer
  validates :user_id, uniqueness: { scope: [:question_id,:answer_id], message: "User can only vote once" }
  validates :value, presence: true 

  def self.for_question question_id, user_id, value
  	    self.create!(user_id: user_id, question_id: question_id, value: value)
  end

  def self.for_answer answer_id, user_id, value
  		self.create!(user_id: user_id, answer_id: answer_id, value: value)
  end
end
