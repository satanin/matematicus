User.create!(
  username: "fernandorevilla",
  email: "fe_rejim@yahoo.es",
  password: "p314e271",
  confirmation_token: nil,
  confirmed_at: Time.now.utc,
  confirmation_sent_at: Time.now.utc
  )

User.create!(
  username: "elreplicante",
  email: "replymusic@gmail.com",
  password: "12345678",
  confirmation_token: nil,
  confirmed_at: Time.now.utc,
  confirmation_sent_at: Time.now.utc
  )

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
  title: "Matrices y determinantes",
  body: "This is question's one body",
  user_id: 1
  )


Answer.create!(
  body: "Answer's body",
  question_id: 1,
  user_id: 2
  )

Question.create!(
  title: "Matrices y determinantes",
  body: "This is question's one body",
  user_id: 1
  )


Answer.create!(
  body: "La respuesta",
  question_id: 1,
  user_id: 2
  )