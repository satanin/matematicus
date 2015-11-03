require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  context "when user is not logged in" do
    describe "trying to see any user profile" do
      it "redirects to login" do
        get :show, id: 1

        expect(response).to redirect_to(new_user_session_path)
        expect(response.status).to be 302
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

    xit "can access to his profile" do
      get :show, id: user.id

      expect(response.status).to eq(200)
      expect(response).to render_template(:show)
      expect(assigns(@user)).to_not be nil
    end

  end

  context "When user is logged in" do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }


    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user.confirm
      sign_in user
    end

    describe "trying to see his profile" do

      it "can access to his profile" do
        get :show, id: user.id

        expect(response.status).to eq(200)
        expect(response).to render_template(:show)
        expect(assigns(@user)).to_not be nil
      end

      it "can edit his profile" do
        get :edit, id: user.id

        expect(response.status).to be 200

        put :update, id: user.id, user: { username: 'Test'}

        expect(response.status).to eq(302)
        expect(response).to redirect_to user_path(user)
        expect(assigns(:user).username).to eq 'Test'
      end
    end

    describe "trying to see other users private profile" do

      it "cannot see other users profile" do
        get :show, id: another_user.id

        expect(response.status).to be 302
        expect(response).to redirect_to user_path(user)
      end
    end
  end
end
