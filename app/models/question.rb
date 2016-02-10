class Question < ActiveRecord::Base
  has_many :answers
  has_many :question_comments
  has_many :votes
  belongs_to :user
  has_and_belongs_to_many :tags

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 300 }
  validates :body, presence: true
  validates :tags, presence: true

  MOST_VIEWED_LIMIT = 5

  def increase_views
    self.times_viewed += 1
    self.save
  end

  def can_be_edited_by? user
    user.questions.map{|q| q[:id] }.include?(self.id)
  end

  def self.tagged_with tag_id
    questions = order(created_at: :desc).joins(:tags).where('tags.id': tag_id)
    questions
  end

  def votes_value
    votes_value = Vote.where(question_id: self.id).sum(:value)
    votes_value.to_s
  end

  def self.most_viewed
    self.order(times_viewed: :desc).limit(MOST_VIEWED_LIMIT)
  end

  def self.ordered_by_answer_date
    self.order(answered_at: :desc)
  end

  def self.for user_id, params
    question = new(params)
    question.user_id = user_id
    question.answered_at = Time.now
    question.save!
    question
  end

end
