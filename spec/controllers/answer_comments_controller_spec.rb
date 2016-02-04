require 'rails_helper'

RSpec.describe AnswerCommentsController, type: :controller do

  let (:user) { create(:user_with_questions, questions_count: 15) }
  let (:user_answering) { create(:user_with_answers, answers_count: 15) }
  let (:user_commenting) { create(:user) }
  let (:real_question) { create(:question) }

  context "when answer has comments" do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user_commenting.confirm
      sign_in user_commenting
      answer = create(:answer, question: real_question)
    end

    describe "GET #new" do
      let(:answer_comment_params){ {question_id: real_question.id, answer_id: real_question.answers.first.id} }

      it "returns http success" do
        get :new, answer_comment_params

        expect(response).to have_http_status(:success)
      end

      it "instantiates environment correctly" do
        get :new, answer_comment_params

        expect(assigns(:comment)).to_not be nil
      end
    end

    describe "POST #create" do
      let(:answer_comment){ 
        {
          body: "Nuevo Body", 
          user_id: user_commenting, 
          answer_id: real_question.answers.first.id
        } 
      }
      
      let(:answer_comment_params){
        {
          question_id: real_question.id, 
          answer_id: real_question.answers.first.id, 
          answer_comment: answer_comment
          }
        }

      it "returns http redirection" do
        post :create, answer_comment_params

        expect(response.status).to eq 302
      end

      it "redirects to question path after comment is saved" do
        comments = AnswerComment.all.count
        post :create, answer_comment_params

        expect(AnswerComment.all.count).to eq comments+1
        expect(response).to redirect_to question_path(assigns(:question))
      end

      it "instantiates environment correctly" do
        post :create, answer_comment_params

        expect(assigns(:user).id).to eq user_commenting.id
        expect(assigns(:comment).body).to eq "Nuevo Body"
      end

      it "renders new if cannot be persisted" do
        post :create, question_id: real_question.id , answer_id: real_question.answers.first.id, answer_comment: { body: nil, user_id: user_commenting, answer_id: real_question.answers.first.id }

        expect(response.status).to eq 200
        expect(response).to render_template 'new'
        expect(assigns(:comment).errors).to_not be nil
      end
    end

    context 'comment with answers' do

      before do
        create(:answer_comment, answer: real_question.answers.first)
      end

      describe "GET #edit" do
        it "return http success" do
          get :edit, question_id: real_question.id , answer_id: real_question.answers.first.id, id: real_question.answers.first.answer_comments.first.id

          expect(response.status).to eq 200
        end
      end

      describe "PUT #update" do

        it "redirects to question path if persisted" do
          put :update, question_id: real_question.id , answer_id: real_question.answers.first.id, id: real_question.answers.first.answer_comments.first.id, answer_comment: { body: "Test", user_id: user_commenting, answer_id: real_question.answers.first.id }

          expect(response.status).to eq 302
        end

        it "edits comment successfully" do
          put :update, question_id: real_question.id , answer_id: real_question.answers.first.id, id: real_question.answers.first.answer_comments.first.id, answer_comment: { body: "Test", user_id: user_commenting, answer_id: real_question.answers.first.id }        

          expect(assigns(:comment).body).to eq "Test"
        end

        it "redirects to question path if not persisted" do
          put :update, question_id: real_question.id , answer_id: real_question.answers.first.id, id: real_question.answers.first.answer_comments.first.id, answer_comment: { body: nil, user_id: user_commenting, answer_id: real_question.answers.first.id }

          expect(response).to render_template 'edit'
        end
      end
    end
  end
end
