require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context "when user is not logged in" do
    describe "trying to see any user profile" do
      it "redirects to login" do
        get :show, id: 1
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context "When log in with google" do
    let(:user) { create(:user) }

    before do
      Rails.application.env_config["devise.mapping"] = Devise.mappings[:user] # If using Devise
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
      user.confirm
      sign_in user
    end

    it "can access to his profile" do
      get :show, id: user.id

      expect(response.status).to eq(200) 
    end

  end

  context "When user is logged in" do
    let(:user) { create(:user) }

    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user.confirm
      sign_in user
    end
    
    describe "trying to see his profile" do


      it "can access to his profile" do
        get :show, id: user.id
        expect(response.status).to eq(200) 
      end
    end

    it "can see all his questions" do
      myquestions = create_list(:question, 10, user_id: user.id)

      expect(user.questions.count).to eq(10)
    end
  end
end
