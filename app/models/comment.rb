class Comment < Post
  belongs_to :user
  belongs_to :question
  belongs_to :answer

  validates :user_id, presence: true
  validates :body, presence: true

end