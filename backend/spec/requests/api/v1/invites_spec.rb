require 'rails_helper'

RSpec.describe "Api::V1::Invites", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:group) { FactoryBot.create(:group) }
  let!(:meeting) { FactoryBot.create(:meeting, group: group) }

  describe "#create" do
    it "meeting, user and kind are valid" do
      new_invite = FactoryBot.build(:invite, meeting: meeting, user: user)
      expect do
        post api_v1_invites_path, params: {
          meeting_id: meeting.id,
          user_id: user.id,
          kind: new_invite.kind
        }
      end.to change(Invite, :count).by(1)
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["meeting_id"]).to eq new_invite.meeting_id
      expect(json["data"]["user_id"]).to eq new_invite.user_id
      expect(json["data"]["kind"]).to eq new_invite.kind
    end

    it "can't create if meeting is empty" do
      new_invite = FactoryBot.build(:invite, user: user)
      post api_v1_invites_path, params: {
        user_id: new_invite.user_id,
        kind: new_invite.kind
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't create if user is empty" do
      new_invite = FactoryBot.build(:invite, meeting: meeting)
      post api_v1_invites_path, params: {
        meeting_id: new_invite.meeting_id,
        kind: new_invite.kind
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't create if kind is empty" do
      new_invite = FactoryBot.build(:invite, meeting: meeting, user: user)
      post api_v1_invites_path, params: {
        meeting_id: new_invite.meeting_id,
        user_id: new_invite.user_id
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't create if kind is string" do
      new_invite = FactoryBot.build(:invite, :kind_is_string, meeting: meeting, user: user)
      post api_v1_invites_path, params: {
        meeting_id: new_invite.meeting_id,
        user_id: new_invite.user_id,
        kind: new_invite.kind
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't create if kind is 0" do
      new_invite = FactoryBot.build(:invite, :kind_is_0, meeting: meeting, user: user)
      post api_v1_invites_path, params: {
        meeting_id: new_invite.meeting_id,
        user_id: new_invite.user_id,
        kind: new_invite.kind
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "create if kind is 1" do
      new_invite = FactoryBot.build(:invite, meeting: meeting, user: user)
      post api_v1_invites_path, params: {
        meeting_id: new_invite.meeting_id,
        user_id: new_invite.user_id,
        kind: new_invite.kind
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["kind"]).to eq new_invite.kind
    end

    it "create if kind is 3" do
      new_invite = FactoryBot.build(:invite, :kind_is_3, meeting: meeting, user: user)
      post api_v1_invites_path, params: {
        meeting_id: new_invite.meeting_id,
        user_id: new_invite.user_id,
        kind: new_invite.kind
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["kind"]).to eq new_invite.kind
    end

    it "can't create if kind is 4" do
      new_invite = FactoryBot.build(:invite, :kind_is_4, meeting: meeting, user: user)
      post api_v1_invites_path, params: {
        meeting_id: new_invite.meeting_id,
        user_id: new_invite.user_id,
        kind: new_invite.kind
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end
  end

  describe "#show" do
    let!(:invite) { FactoryBot.create(:invite, meeting: meeting, user: user) }

    it "data exists" do
      get api_v1_invite_path(id: invite.id)
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["meeting_id"]).to eq invite.meeting_id
      expect(json["data"]["user_id"]).to eq invite.user_id
      expect(json["data"]["kind"]).to eq invite.kind
    end

    it "data does not exist" do
      get api_v1_invite_path(id: invite.id + 1)
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが存在しません"
    end
  end

  describe "#update" do
    let(:new_user) { FactoryBot.create(:user, :new_user) }
    let(:new_group) { FactoryBot.create(:group, :new_group) }
    let(:new_meeting) { FactoryBot.create(:meeting, group: group) }
    let!(:invite) { FactoryBot.create(:invite, meeting: meeting, user: user) }

    it "data exists" do
      put api_v1_invite_path(id: invite.id), params: {
        meeting_id: invite.meeting_id,
        user_id: invite.user_id,
        kind: invite.kind
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["meeting_id"]).to eq invite.meeting_id
      expect(json["data"]["user_id"]).to eq invite.user_id
      expect(json["data"]["kind"]).to eq invite.kind
    end

    it "invite does not exist" do
      put api_v1_invite_path(id: invite.id + 1), params: {
        meeting_id: invite.meeting_id,
        user_id: invite.user_id,
        kind: invite.kind
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが存在しません"
    end

    it "meeting does not exist" do
      put api_v1_invite_path(id: invite.id), params: {
        meeting_id: invite.meeting_id + 1,
        user_id: invite.user_id,
        kind: invite.kind
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "user does not exist" do
      put api_v1_invite_path(id: invite.id), params: {
        meeting_id: invite.meeting_id,
        user_id: invite.user_id + 1,
        kind: invite.kind
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't update if meeting is empty" do
      new_invite = FactoryBot.build(:invite, user: user)
      put api_v1_invite_path(id: invite.id), params: {
        meeting_id: nil,
        user_id: new_invite.user_id,
        kind: new_invite.kind
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't update if user is empty" do
      new_invite = FactoryBot.build(:invite, meeting: meeting)
      put api_v1_invite_path(id: invite.id), params: {
        meeting_id: new_invite.meeting_id,
        user_id: nil,
        kind: new_invite.kind
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't update if kind is empty" do
      new_invite = FactoryBot.build(:invite, :kind_is_blank, meeting: meeting, user: user)
      put api_v1_invite_path(id: invite.id), params: {
        meeting_id: new_invite.meeting_id,
        user_id: new_invite.user_id,
        kind: new_invite.kind
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't update if kind is string" do
      new_invite = FactoryBot.build(:invite, :kind_is_string, meeting: meeting, user: user)
      put api_v1_invite_path(id: invite.id), params: {
        meeting_id: new_invite.meeting_id,
        user_id: new_invite.user_id,
        kind: new_invite.kind
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't update if kind is 0" do
      new_invite = FactoryBot.build(:invite, :kind_is_0, meeting: meeting, user: user)
      put api_v1_invite_path(id: invite.id), params: {
        meeting_id: new_invite.meeting_id,
        user_id: new_invite.user_id,
        kind: new_invite.kind
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "update if kind is 1" do
      new_invite = FactoryBot.build(:invite, meeting: meeting, user: user)
      put api_v1_invite_path(id: invite.id), params: {
        meeting_id: new_invite.meeting_id,
        user_id: new_invite.user_id,
        kind: new_invite.kind
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["kind"]).to eq new_invite.kind
    end

    it "update if kind is 3" do
      new_invite = FactoryBot.build(:invite, :kind_is_3, meeting: meeting, user: user)
      put api_v1_invite_path(id: invite.id), params: {
        meeting_id: new_invite.meeting_id,
        user_id: new_invite.user_id,
        kind: new_invite.kind
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["kind"]).to eq new_invite.kind
    end

    it "can't update if kind is 4" do
      new_invite = FactoryBot.build(:invite, :kind_is_4, meeting: meeting, user: user)
      put api_v1_invite_path(id: invite.id), params: {
        meeting_id: new_invite.meeting_id,
        user_id: new_invite.user_id,
        kind: new_invite.kind
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end
  end

  describe "#destroy" do
    let!(:invite) { FactoryBot.create(:invite, meeting: meeting, user: user) }

    it "data exists" do
      delete api_v1_invite_path(id: invite.id)
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["message"]).to eq "削除しました"
      expect(json["data"]["meeting_id"]).to eq invite.meeting_id
      expect(json["data"]["user_id"]).to eq invite.user_id
      expect(json["data"]["kind"]).to eq invite.kind
    end

    it "data does not exist" do
      delete api_v1_invite_path(id: invite.id + 1)
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが存在しません"
    end
  end
end
