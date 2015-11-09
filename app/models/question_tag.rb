class QuestionTag < ActiveRecord::Base
  belongs_to :question
  belongs_to :tag


  def self.associate_tags_to_question question, tag_ids
    puts ")*("*20
    tag_ids = tag_ids.reject {|t| t.blank? }
    puts "*"*20
    question.tags.destroy_all

    tag_ids.each do  |t|
      QuestionTag.create(tag_id: t, question_id: question.id)
    end
  end
end
