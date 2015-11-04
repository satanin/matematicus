User.create!(
  username: "John Doe",
  email: "johndoe@test.com",
  password: "12345678",
  confirmation_token: nil,
  confirmed_at: Time.now.utc,
  confirmation_sent_at: Time.now.utc
  )

User.create!(
  username: "Jane Doe",
  email: "janedoe@test.com",
  password: "12345678",
  confirmation_token: nil,
  confirmed_at: Time.now.utc,
  confirmation_sent_at: Time.now.utc
  )

Question.create!(
  title: "This is question one",
  body: "This is question's one body",
  user_id: 1
  )

QuestionComment.create!(
  body: "This is a comment for Question one.",
  question_id: 1,
  user_id: 2
  )

Answer.create!(
  body: "Answer's body",
  question_id: 1,
  user_id: 2
  )

AnswerComment.create!(
  body: "This is a comment for Answer",
  answer_id: 1,
  user_id: 1
  )