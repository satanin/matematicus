class Question < ActiveRecord::Base
  has_many :answers
  has_many :question_comments
  belongs_to :user

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 300 }
  validates :body, presence: true


  def increase_views
    self.times_viewed += 1
    self.save
  end

end
