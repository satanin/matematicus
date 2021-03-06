class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  has_many :answer_comments
  has_many :votes

  validates :user_id, presence: true
  validates :question_id, presence: true
  validates :body, presence: true

  def votes_value
    votes_value = Vote.where(answer_id: self.id).sum(:value)
    votes_value.to_s
  end


  def self.most_voted
    self.all.sort_by{ |answer| answer.votes_value }.reverse[0..4]
  end

end