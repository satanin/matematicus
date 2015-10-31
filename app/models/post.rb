class Post < ActiveRecord::Base
  belongs_to :user
  scope :questions, -> { where(type: 'Question') }
  scope :answers, -> { where(type: 'Answer') }

end
