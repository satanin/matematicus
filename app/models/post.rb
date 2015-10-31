class Post < ActiveRecord::Base
  scope :questions, -> { where(type: 'Question') }
  scope :answers, -> { where(type: 'Answer') }
  scope :comments, -> { where(type: 'Comment')}
end
