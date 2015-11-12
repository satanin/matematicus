FactoryGirl.define do
  factory :vote do
    value ramdomvote
    user
    question
  end

end

def ramdomvote
  value = 0
  value = Random.rand(-1..1) while value == 0
  return value
end