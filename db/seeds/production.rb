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

Tag.create!(name: "sumas", description: "Preguntas relacionadas con sumas")
Tag.create!(name: "restas", description: "Preguntas relacionadas con restas")
Tag.create!(name: "multiplicaciones", description: "Preguntas relacionadas con multiplicaciones")
Tag.create!(name: "derivadas", description: "Preguntas relacionadas con derivadas")
Tag.create!(name: "sumas complejas", description: "Preguntas relacionadas con sumas complejas")
Tag.create!(name: "restas difíciles", description: "Preguntas relacionadas con restas difíciles")
Tag.create!(name: "divisiones", description: "Preguntas relacionadas con divisiones")
Tag.create!(name: "integrales", description: "Preguntas relacionadas con integrales")
