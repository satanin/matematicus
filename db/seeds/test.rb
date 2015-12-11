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

Question.new(
  title: "This is question one",
  body: "This is question's one body",
  user_id: 1
  ).save(validate: false)

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


Tag.create!(name: "álgebra")
Tag.create!(name: "conjuntos")
Tag.create!(name: "relaciones")
Tag.create!(name: "funciones")
Tag.create!(name: "grupos")
Tag.create!(name: "anillos")
Tag.create!(name: "cuerpos")
Tag.create!(name: "sistemas lineales")
Tag.create!(name: "matrices")
Tag.create!(name: "determinantes")
Tag.create!(name: "espacios vectoriales")
Tag.create!(name: "aplicaciones lineales")
Tag.create!(name: "valores y vectores propios")
Tag.create!(name: "formas de jordan")
Tag.create!(name: "formas bilineales")
Tag.create!(name: "formas cuadráticas")
Tag.create!(name: "producto escalar")
Tag.create!(name: "números complejos")
Tag.create!(name: "polinomios")
Tag.create!(name: "cónicas")
Tag.create!(name: "cuádricas")
Tag.create!(name: "superficies")
Tag.create!(name: "programación lineal")
Tag.create!(name: "cálculo")
Tag.create!(name: "análisis")
Tag.create!(name: "método de inducción")
Tag.create!(name: "sucesiones")
Tag.create!(name: "continuidad")
Tag.create!(name: "teoremas del valor medio")
Tag.create!(name: "formula de taylor")
Tag.create!(name: "regla de l'hopital")
Tag.create!(name: "integrales indefinidas")
Tag.create!(name: "integrales definidas")
Tag.create!(name: "series numéricas")
Tag.create!(name: "series funcionales")
Tag.create!(name: "análisis multivariable")
Tag.create!(name: "espacios normados")
Tag.create!(name: "análisis complejo")
Tag.create!(name: "ecuaciones diferenciales")
Tag.create!(name: "ecuaciones de primer orden y primer grado")
Tag.create!(name: "transformadas de laplace")
Tag.create!(name: "sistemas autónomos")
Tag.create!(name: "topología")
Tag.create!(name: "geometría diferencial")
Tag.create!(name: "métodos numéricos")
Tag.create!(name: "teoría de números")
Tag.create!(name: "lógica matemática­­­­­­­­­­­­­­­­­­­­")
Tag.create!(name: "matemáticas de enseñanza media")