class Question < Post
  has_many :answers

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 300 }
  validates :body, presence: true

end
