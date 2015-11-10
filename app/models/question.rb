class Question < ActiveRecord::Base
  has_many :answers
  has_many :question_comments
  belongs_to :user
  has_and_belongs_to_many :tags

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 300 }
  validates :body, presence: true
  validates :tags, presence: true


  def increase_views
    self.times_viewed += 1
    self.save
  end

  def can_be_edited_by? user
    user.questions.map{|q| q[:id] }.include?(self.id)
  end

  def self.tagged_with tag
    Question.order(created_at: :desc).joins(:tags).where('tags.id': tag.id)
  end

end
