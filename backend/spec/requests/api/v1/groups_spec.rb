require 'rails_helper'

RSpec.describe "Api::V1::Groups", type: :request do
  describe "#create" do
    it "space, name and content are valid" do
      group = FactoryBot.build(:group)
      expect do
        post api_v1_groups_path, params: {
          space: group.space,
          name: group.name,
          content: group.content
        }
      end.to change(Group, :count).by(1)
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["space"]).to eq group.space
      expect(json["data"]["name"]).to eq group.name
      expect(json["data"]["content"]).to eq group.content
    end

    it "can't create if space is empty" do
      new_group = FactoryBot.build(:group, :space_is_blank)
      post api_v1_groups_path, params: {
        space: new_group.space,
        name: new_group.name,
        content: new_group.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't create if name is empty" do
      new_group = FactoryBot.build(:group, :name_is_blank)
      post api_v1_groups_path, params: {
        space: new_group.space,
        name: new_group.name,
        content: new_group.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "create if name is 1 character" do
      new_group = FactoryBot.build(:group, :one_char_name)
      post api_v1_groups_path, params: {
        space: new_group.space,
        name: new_group.name,
        content: new_group.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["name"]).to eq new_group.name
    end

    it "create if name is 20 character" do
      new_group = FactoryBot.build(:group, :twenty_char_name)
      post api_v1_groups_path, params: {
        space: new_group.space,
        name: new_group.name,
        content: new_group.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["name"]).to eq new_group.name
    end

    it "can't create if name is 21 character" do
      new_group = FactoryBot.build(:group, :twenty_one_char_name)
      post api_v1_groups_path, params: {
        space: new_group.space,
        name: new_group.name,
        content: new_group.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "create if content is empty" do
      new_group = FactoryBot.build(:group, :content_is_blank)
      post api_v1_groups_path, params: {
        space: new_group.space,
        name: new_group.name,
        content: new_group.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["content"]).to eq new_group.content
    end

    it "create if content is 300 character" do
      new_group = FactoryBot.build(:group, :three_hundred_char_content)
      post api_v1_groups_path, params: {
        space: new_group.space,
        name: new_group.name,
        content: new_group.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["content"]).to eq new_group.content
    end

    it "can't create if content is 301 character" do
      new_group = FactoryBot.build(:group, :three_hundred_one_char_content)
      post api_v1_groups_path, params: {
        space: new_group.space,
        name: new_group.name,
        content: new_group.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end
  end

  describe "#show" do
    let!(:group) { FactoryBot.create(:group) }

    it "data exists" do
      get api_v1_group_path(id: group.id)
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["space"]).to eq group.space
      expect(json["data"]["name"]).to eq group.name
      expect(json["data"]["content"]).to eq group.content
    end

    it "data does not exist" do
      get api_v1_group_path(id: group.id + 1)
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが存在しません"
    end
  end

  describe "#update" do
    let!(:group) { FactoryBot.create(:group) }

    it "data exists" do
      new_group = FactoryBot.create(:group, :new_group)
      put api_v1_group_path(id: group.id), params: {
        id: group.id,
        space: new_group.space,
        name: new_group.name,
        content: new_group.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["space"]).to eq new_group.space
      expect(json["data"]["name"]).to eq new_group.name
      expect(json["data"]["content"]).to eq new_group.content
    end

    it "data does not exist" do
      new_group = FactoryBot.build(:group, :new_group)
      put api_v1_group_path(id: group.id + 1), params: {
        id: group.id + 1,
        space: new_group.space,
        name: new_group.name,
        content: new_group.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが存在しません"
    end

    it "can't update if space is empty" do
      new_group = FactoryBot.build(:group, :space_is_blank)
      put api_v1_group_path(id: group.id), params: {
        id: group.id,
        space: new_group.space,
        name: new_group.name,
        content: new_group.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't update if name is empty" do
      new_group = FactoryBot.build(:group, :name_is_blank)
      put api_v1_group_path(id: group.id), params: {
        id: group.id,
        space: new_group.space,
        name: new_group.name,
        content: new_group.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "update if name is 1 character" do
      new_group = FactoryBot.build(:group, :one_char_name)
      put api_v1_group_path(id: group.id), params: {
        id: group.id,
        space: new_group.space,
        name: new_group.name,
        content: new_group.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["name"]).to eq new_group.name
    end

    it "update if name is 20 character" do
      new_group = FactoryBot.build(:group, :twenty_char_name)
      put api_v1_group_path(id: group.id), params: {
        id: group.id,
        space: new_group.space,
        name: new_group.name,
        content: new_group.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["name"]).to eq new_group.name
    end

    it "can't update if name is 21 character" do
      new_group = FactoryBot.build(:group, :twenty_one_char_name)
      put api_v1_group_path(id: group.id), params: {
        id: group.id,
        space: new_group.space,
        name: new_group.name,
        content: new_group.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "update if content is empty" do
      new_group = FactoryBot.build(:group, :content_is_blank)
      put api_v1_group_path(id: group.id), params: {
        id: group.id,
        space: new_group.space,
        name: new_group.name,
        content: new_group.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["content"]).to eq new_group.content
    end

    it "update if content is 300 character" do
      new_group = FactoryBot.build(:group, :three_hundred_char_content)
      put api_v1_group_path(id: group.id), params: {
        id: group.id,
        space: new_group.space,
        name: new_group.name,
        content: new_group.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["content"]).to eq new_group.content
    end

    it "can't update if content is 301 character" do
      new_group = FactoryBot.build(:group, :three_hundred_one_char_content)
      put api_v1_group_path(id: group.id), params: {
        id: group.id,
        space: new_group.space,
        name: new_group.name,
        content: new_group.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end
  end

  describe "#destroy" do
    let!(:group) { FactoryBot.create(:group) }

    it "data exists" do
      delete api_v1_group_path(id: group.id)
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["message"]).to eq "削除しました"
      expect(json["data"]["space"]).to eq group.space
      expect(json["data"]["name"]).to eq group.name
      expect(json["data"]["content"]).to eq group.content
    end

    it "data does not exist" do
      delete api_v1_group_path(id: group.id + 1)
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが存在しません"
    end
  end
end
