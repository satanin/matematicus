require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let (:user) { create(:user_with_questions, questions_count: 15) }
  let (:user_answering) { create(:user_with_answers, answers_count: 15) }
  let (:user_commenting) { create(:user) }
  let (:comment) { build(:comment) }


  context "when question has comments" do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user_commenting.confirm
      sign_in user_commenting
    end

    describe "GET #new" do
      it "returns http success" do
        get :new, question_id: user.questions.first.id

        expect(response).to have_http_status(:success)
      end

      it "instantiates environment correctly" do
        get :new, question_id: user.questions.first.id

        expect(assigns(:environment_variables).count).to eq 2
        expect(assigns(:environment_variables)[0]).to eq user.questions.first
        expect(assigns(:environment_variables)[1]).to eq assigns(:comment)
      end
    end

    describe "POST #create" do
      it "returns http success" do
        post :create, question_id: user.questions.first.id, comment: { body: "Nuevo Body" }

        expect(response.status).to eq 302
      end

      it "redirects to question path after comment is saved" do
        comments = Comment.all.count
        post :create, question_id: user.questions.first.id, comment: { body: "Nuevo Body" }

        expect(Comment.all.count).to eq comments+1
        expect(response).to redirect_to question_path(assigns(:question))
      end

      it "instantiates environment correctly" do
        post :create, question_id: user.questions.first.id, comment: { body: "Nuevo Body" }

        expect(assigns(:user).id).to eq user_commenting.id
        expect(assigns(:comment).body).to eq "Nuevo Body"
      end
    end

  end

  context "when answer has comments" do

    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user_answering.confirm
      user.confirm
      user_commenting.confirm
      sign_in user_commenting
    end

    describe "GET #new" do
      it "returns http successs" do
        question = user.questions.first
        answer = user_answering.answers.first

        get :new, question_id: question.id, answer_id: answer.id

        expect(response.status).to eq 200
      end

      it "instantiates environment correctly" do
        question = user.questions.first
        answer = user_answering.answers.first

        get :new, question_id: question.id, answer_id: answer.id

        expect(assigns(:environment_variables).count).to eq 3
        expect(assigns(:environment_variables)[0]).to eq question
        expect(assigns(:environment_variables)[1]).to eq answer
        expect(assigns(:environment_variables)[2]).to eq assigns(:comment)
      end

      it "renders the correct template" do
        question = user.questions.first
        answer = user_answering.answers.first

        get :new, question_id: question.id, answer_id: answer.id

        expect(response).to render_template(:new)
      end
    end

    describe "POST #create" do

      it "returns http successs" do
        question = user.questions.first
        answer = user_answering.answers.first

        post :create, question_id: question.id, answer_id: answer.id ,comment: { body: "Nuevo Body" }

        expect(response.status).to eq 302
        expect(response).to redirect_to question_path(question)
      end

      it "instantiates environment correctly" do
        question = user.questions.first
        answer = user_answering.answers.first

        post :create, question_id: question.id, answer_id: answer.id ,comment: { body: "Nuevo Body" }

        expect(assigns(:comment).body).to eq "Nuevo Body"
        expect(assigns(:question)).to eq question
        expect(assigns(:answer)).to eq answer
      end
    end
  end

end
