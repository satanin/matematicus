class Answer < Post
  belongs_to :user
  belongs_to :question
  has_many :comments

  validates :user_id, presence: true
  validates :question_id, presence: true
  validates :body, presence: true

end