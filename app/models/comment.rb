class Comment < Post
  belongs_to :user
  belongs_to :question
  belongs_to :answer

  validates :user_id, presence: true
  validates :body, presence: true
  validates :question_id, presence: true, if: :for_question?
  validates :answer_id, presence: true, if: :for_answer?

  def for_question?
    self.answer_id.nil?
  end

  def for_answer?
    self.question_id.nil?
  end
end
