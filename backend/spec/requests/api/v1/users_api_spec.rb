require 'rails_helper'

RSpec.describe "V1::UsersApis", type: :request do
  let(:new_user) { FactoryBot.build(:user, :new_user) }

  describe "not sign in" do
    describe "#sign up" do
      let!(:user) { FactoryBot.create(:user) }

      it "unique name and email are valid" do
        expect {
          post api_v1_user_registration_path, params: {
            name: new_user.name,
            email: new_user.email,
            password: new_user.password,
            password_confirmation: new_user.password,
            confirm_success_url: "http://localhost:3000/sign_in"
          }
        }.to change(User, :count).by(1)
        expect(response).to have_http_status(:success)
      end

      it "duplicate name is invalid" do
        expect {
          post api_v1_user_registration_path, params: {
            name: user.name,
            email: new_user.email,
            password: new_user.password,
            password_confirmation: new_user.password,
            confirm_success_url: "http://localhost:3000/sign_in"
          }
        }.to change(User, :count).by(0)
        expect(response).to have_http_status(422)
      end

      it "duplicate email is invalid" do
        expect {
          post api_v1_user_registration_path, params: {
            name: new_user.name,
            email: user.email,
            password: new_user.password,
            password_confirmation: new_user.password,
            confirm_success_url: "http://localhost:3000/sign_in"
          }
        }.to change(User, :count).by(0)
        expect(response).to have_http_status(422)
      end
    end

    it "non registered user sign in" do
      post api_v1_user_session_path, params: { email: new_user.email, password: new_user.password }
      expect(response).to have_http_status(401)
    end

    it "unauthenticated sign in" do
      user = FactoryBot.create(:user, :not_confirmationed)
      post api_v1_user_session_path, params: { email: user.email, password: user.password }
      expect(response).to have_http_status(401)
    end

    it "authenticated sign in" do
      user = FactoryBot.create(:user)
      post api_v1_user_session_path, params: { email: user.email, password: user.password }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["data"]["name"]).to eq user.name
      expect(json["data"]["email"]).to eq user.email
    end

    it "sign out" do
      delete destroy_api_v1_user_session_path
      expect(response).to have_http_status(404)
    end
  end

  describe "authenticated sign in" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:token) { sign_in user }

    it "#sessions" do
      get api_v1_auth_sessions_path, headers: token
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["current_user"]["name"]).to eq user.name
      expect(json["current_user"]["email"]).to eq user.email
    end

    describe "#auth/update" do
      let!(:duplicate_user) { FactoryBot.create(:user, :new_user) }
      
      it "update name" do
        user.name = "new name"
        put api_v1_user_registration_path, params: { name: user.name }, headers: token
        expect(response).to have_http_status(:success)
        json = JSON.parse(response.body)
        expect(json["data"]["name"]).to eq user.name
        expect(User.find(user.id).name).to eq user.name
      end

      it "duplicate name is invalid" do
        expect {
          put api_v1_user_registration_path, params: { name: duplicate_user.name }, headers: token
        }.to change(User, :count).by(0)
        expect(response).to have_http_status(422)
      end

      it "update email" do
        user.email = "new@example.com"
        put api_v1_user_registration_path, params: { email: user.email }, headers: token
        expect(response).to have_http_status(:success)
        json = JSON.parse(response.body)
        expect(json["data"]["email"]).to eq user.email
        expect(User.find(user.id).email).to eq user.email
      end

      it "duplicate email is invalid" do
        expect {
          put api_v1_user_registration_path, params: { email: duplicate_user.email }, headers: token
        }.to change(User, :count).by(0)
        expect(response).to have_http_status(422)
      end

      it "password is invalid" do
        put api_v1_user_registration_path, params: { password: "new password", password_confirmation: "new password" }, headers: token
        expect(response).to have_http_status(422)
      end
    end

    describe "#auth/password/update" do
      it "password update" do
        new_password = "new_password"
        expect {
          put api_v1_user_password_path, params: { password: new_password, password_confirmation: new_password }, headers: token
        }.to change(User, :count).by(0)
        expect(response).to have_http_status(:success)
        post api_v1_user_session_path, params: { email: user.email, password: user.password }
        expect(response).to have_http_status(401)
        post api_v1_user_session_path, params: { email: user.email, password: new_password }
        expect(response).to have_http_status(:success)
      end

      it "name is invalid" do
        user.name = "new name"
        expect {
          put api_v1_user_password_path, params: { name: user.name }, headers: token
        }.to change(User, :count).by(0)
        expect(response).to have_http_status(422)
      end

      it "email is invalid" do
        user.email = "new@example.com"
        expect {
          put api_v1_user_password_path, params: { email: user.email }, headers: token
        }.to change(User, :count).by(0)
        expect(response).to have_http_status(422)
      end
    end

    it "#sign out" do
      delete destroy_api_v1_user_session_path, headers: token
      expect(response).to have_http_status(:success)
    end
  end
end
