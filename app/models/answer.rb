class Answer < Post
  belongs_to :user
  belongs_to :question

  validates :user_id, presence: true
  validates :body, presence: true

end