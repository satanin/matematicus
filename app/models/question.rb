class Question < ActiveRecord::Base
  has_many :answers
  has_many :question_comments
  has_many :question_tags
  has_many :tags, through: :question_tags
  belongs_to :user

  accepts_nested_attributes_for :question_tags

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 300 }
  validates :body, presence: true


  def increase_views
    self.times_viewed += 1
    self.save
  end

  def can_be_edited_by? user
    user.questions.map{|q| q[:id] }.include?(self.id)
  end

end
