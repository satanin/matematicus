class Question < Post
  has_many :answers
  has_many :comments
  belongs_to :user

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 300 }
  validates :body, presence: true

end
