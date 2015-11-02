class Post < ActiveRecord::Base

  def initialize(*args)
    raise "Cannot directly instantiate a #{self.class}" if self.class == Post
    super
  end
  scope :questions, -> { where(type: 'Question') }
  scope :answers, -> { where(type: 'Answer') }
  scope :comments, -> { where(type: 'Comment')}
end
