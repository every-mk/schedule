require 'rails_helper'

RSpec.describe "Api::V1::Permissions", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:group) { FactoryBot.create(:group) }

  describe "#create" do
    it "group, user, privilege, join and post are valid" do
      new_permission = FactoryBot.build(:permission, group: group, user: user)
      expect do
        post api_v1_permissions_path, params: {
          group_id: new_permission.group_id,
          user_id: new_permission.user_id,
          privilege: new_permission.privilege,
          join: new_permission.join,
          post: new_permission.post
        }
      end.to change(Permission, :count).by(1)
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["group_id"]).to eq new_permission.group_id
      expect(json["data"]["user_id"]).to eq new_permission.user_id
      expect(json["data"]["privilege"]).to eq new_permission.privilege
      expect(json["data"]["join"]).to eq new_permission.join
      expect(json["data"]["post"]).to eq new_permission.post
    end

    it "can't create if group is empty" do
      new_permission = FactoryBot.build(:permission, user: user)
      post api_v1_permissions_path, params: {
        user_id: new_permission.user_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't create if user is empty" do
      new_permission = FactoryBot.build(:permission, group: group)
      post api_v1_permissions_path, params: {
        group_id: new_permission.group_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't create if privilege is empty" do
      new_permission = FactoryBot.build(:permission, :privilege_is_blank, group: group, user: user)
      post api_v1_permissions_path, params: {
        group_id: new_permission.group_id,
        user_id: new_permission.user_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't create if privilege is string" do
      new_permission = FactoryBot.build(:permission, :privilege_is_string, group: group, user: user)
      post api_v1_permissions_path, params: {
        group_id: new_permission.group_id,
        user_id: new_permission.user_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't create if privilege is 0" do
      new_permission = FactoryBot.build(:permission, :privilege_is_0, group: group, user: user)
      post api_v1_permissions_path, params: {
        group_id: new_permission.group_id,
        user_id: new_permission.user_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "create if privilege is 1" do
      new_permission = FactoryBot.build(:permission, group: group, user: user)
      post api_v1_permissions_path, params: {
        group_id: new_permission.group_id,
        user_id: new_permission.user_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["privilege"]).to eq new_permission.privilege
    end

    it "create if privilege is 3" do
      new_permission = FactoryBot.build(:permission, :privilege_is_3, group: group, user: user)
      post api_v1_permissions_path, params: {
        group_id: new_permission.group_id,
        user_id: new_permission.user_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["privilege"]).to eq new_permission.privilege
    end

    it "can't create if privilege is 4" do
      new_permission = FactoryBot.build(:permission, :privilege_is_4, group: group, user: user)
      post api_v1_permissions_path, params: {
        group_id: new_permission.group_id,
        user_id: new_permission.user_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't create if join is empty" do
      new_permission = FactoryBot.build(:permission, :join_is_blank, group: group, user: user)
      post api_v1_permissions_path, params: {
        group_id: new_permission.group_id,
        user_id: new_permission.user_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "create if join is string" do
      new_permission = FactoryBot.build(:permission, :join_is_string, group: group, user: user)
      post api_v1_permissions_path, params: {
        group_id: new_permission.group_id,
        user_id: new_permission.user_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["join"]).to eq new_permission.join
    end

    it "create if join is true" do
      new_permission = FactoryBot.build(:permission, group: group, user: user)
      post api_v1_permissions_path, params: {
        group_id: new_permission.group_id,
        user_id: new_permission.user_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["join"]).to eq new_permission.join
    end

    it "create if join is false" do
      new_permission = FactoryBot.build(:permission, :join_is_false, group: group, user: user)
      post api_v1_permissions_path, params: {
        group_id: new_permission.group_id,
        user_id: new_permission.user_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["join"]).to eq new_permission.join
    end

    it "can't create if post is empty" do
      new_permission = FactoryBot.build(:permission, :post_is_blank, group: group, user: user)
      post api_v1_permissions_path, params: {
        group_id: new_permission.group_id,
        user_id: new_permission.user_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "create if post is string" do
      new_permission = FactoryBot.build(:permission, :post_is_string, group: group, user: user)
      post api_v1_permissions_path, params: {
        group_id: new_permission.group_id,
        user_id: new_permission.user_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["post"]).to eq new_permission.post
    end

    it "create if post is true" do
      new_permission = FactoryBot.build(:permission, group: group, user: user)
      post api_v1_permissions_path, params: {
        group_id: new_permission.group_id,
        user_id: new_permission.user_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["post"]).to eq new_permission.post
    end

    it "create if post is false" do
      new_permission = FactoryBot.build(:permission, :post_is_false, group: group, user: user)
      post api_v1_permissions_path, params: {
        group_id: new_permission.group_id,
        user_id: new_permission.user_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["post"]).to eq new_permission.post
    end
  end

  describe "#show" do
    let!(:permission) { FactoryBot.create(:permission, group: group, user: user) }

    it "data exists" do
      get api_v1_permission_path(id: permission.id)
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["group_id"]).to eq permission.group_id
      expect(json["data"]["user_id"]).to eq permission.user_id
      expect(json["data"]["privilege"]).to eq permission.privilege
      expect(json["data"]["join"]).to eq permission.join
      expect(json["data"]["post"]).to eq permission.post
    end

    it "data does not exist" do
      get api_v1_permission_path(id: permission.id + 1)
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが存在しません"
    end
  end

  describe "#update" do
    let(:new_group) { FactoryBot.create(:group, :new_group) }
    let(:new_user) { FactoryBot.create(:user, :new_user) }
    let!(:permission) { FactoryBot.create(:permission, group: group, user: user) }

    it "data exists" do
      new_permission = FactoryBot.build(:permission, :new_permission, group: new_group, user: new_user)
      put api_v1_permission_path(id: permission.id), params: {
        group_id: new_permission.group_id,
        user_id: new_permission.user_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["group_id"]).to eq new_permission.group_id
      expect(json["data"]["user_id"]).to eq new_permission.user_id
      expect(json["data"]["privilege"]).to eq new_permission.privilege
      expect(json["data"]["join"]).to eq new_permission.join
      expect(json["data"]["post"]).to eq new_permission.post
    end

    it "data does not exist" do
      new_permission = FactoryBot.build(:permission, :new_permission)
      put api_v1_permission_path(id: group.id + 1), params: {
        group_id: permission.group_id + 1,
        user_id: permission.user_id + 1,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが存在しません"
    end

    it "can't update if group is empty" do
      new_permission = FactoryBot.build(:permission, user: user)
      put api_v1_permission_path(id: permission.id), params: {
        group_id: nil,
        user_id: new_permission.user_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't update if user is empty" do
      new_permission = FactoryBot.build(:permission, group: group)
      put api_v1_permission_path(id: permission.id), params: {
        group_id: new_permission.group_id,
        user_id: nil,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't update if privilege is empty" do
      new_permission = FactoryBot.build(:permission, :privilege_is_blank, group: group, user: user)
      put api_v1_permission_path(id: permission.id), params: {
        group_id: new_permission.group_id,
        user_id: new_permission.user_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't update if privilege is string" do
      new_permission = FactoryBot.build(:permission, :privilege_is_string, group: group, user: user)
      put api_v1_permission_path(id: permission.id), params: {
        group_id: new_permission.group_id,
        user_id: new_permission.user_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't update if privilege is 0" do
      new_permission = FactoryBot.build(:permission, :privilege_is_0, group: group, user: user)
      put api_v1_permission_path(id: permission.id), params: {
        group_id: new_permission.group_id,
        user_id: new_permission.user_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "update if privilege is 1" do
      new_permission = FactoryBot.build(:permission, group: group, user: user)
      put api_v1_permission_path(id: permission.id), params: {
        group_id: new_permission.group_id,
        user_id: new_permission.user_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["privilege"]).to eq new_permission.privilege
    end

    it "update if privilege is 3" do
      new_permission = FactoryBot.build(:permission, :privilege_is_3, group: group, user: user)
      put api_v1_permission_path(id: permission.id), params: {
        group_id: new_permission.group_id,
        user_id: new_permission.user_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["privilege"]).to eq new_permission.privilege
    end

    it "can't update if privilege is 4" do
      new_permission = FactoryBot.build(:permission, :privilege_is_4, group: group, user: user)
      put api_v1_permission_path(id: permission.id), params: {
        group_id: new_permission.group_id,
        user_id: new_permission.user_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't update if join is empty" do
      new_permission = FactoryBot.build(:permission, :join_is_blank, group: group, user: user)
      put api_v1_permission_path(id: permission.id), params: {
        group_id: new_permission.group_id,
        user_id: new_permission.user_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "update if join is string" do
      new_permission = FactoryBot.build(:permission, :join_is_string, group: group, user: user)
      put api_v1_permission_path(id: permission.id), params: {
        group_id: new_permission.group_id,
        user_id: new_permission.user_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["join"]).to eq new_permission.join
    end

    it "update if join is true" do
      new_permission = FactoryBot.build(:permission, group: group, user: user)
      put api_v1_permission_path(id: permission.id), params: {
        group_id: new_permission.group_id,
        user_id: new_permission.user_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["join"]).to eq new_permission.join
    end

    it "update if join is false" do
      new_permission = FactoryBot.build(:permission, :join_is_false, group: group, user: user)
      put api_v1_permission_path(id: permission.id), params: {
        group_id: new_permission.group_id,
        user_id: new_permission.user_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["join"]).to eq new_permission.join
    end

    it "can't update if post is empty" do
      new_permission = FactoryBot.build(:permission, :post_is_blank, group: group, user: user)
      put api_v1_permission_path(id: permission.id), params: {
        group_id: new_permission.group_id,
        user_id: new_permission.user_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "update if post is string" do
      new_permission = FactoryBot.build(:permission, :post_is_string, group: group, user: user)
      put api_v1_permission_path(id: permission.id), params: {
        group_id: new_permission.group_id,
        user_id: new_permission.user_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["post"]).to eq new_permission.post
    end

    it "update if post is true" do
      new_permission = FactoryBot.build(:permission, group: group, user: user)
      put api_v1_permission_path(id: permission.id), params: {
        group_id: new_permission.group_id,
        user_id: new_permission.user_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["post"]).to eq new_permission.post
    end

    it "update if post is false" do
      new_permission = FactoryBot.build(:permission, :post_is_false, group: group, user: user)
      put api_v1_permission_path(id: permission.id), params: {
        group_id: new_permission.group_id,
        user_id: new_permission.user_id,
        privilege: new_permission.privilege,
        join: new_permission.join,
        post: new_permission.post
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["post"]).to eq new_permission.post
    end
  end

  describe "#destroy" do
    let!(:permission) { FactoryBot.create(:permission, group: group, user: user) }

    it "data exists" do
      delete api_v1_permission_path(id: permission.id)
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["message"]).to eq "削除しました"
      expect(json["data"]["group_id"]).to eq permission.group_id
      expect(json["data"]["user_id"]).to eq permission.user_id
      expect(json["data"]["privilege"]).to eq permission.privilege
      expect(json["data"]["join"]).to eq permission.join
      expect(json["data"]["post"]).to eq permission.post
    end

    it "data does not exist" do
      delete api_v1_permission_path(id: permission.id + 1)
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが存在しません"
    end
  end
end
