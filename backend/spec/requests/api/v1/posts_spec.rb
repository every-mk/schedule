require 'rails_helper'

RSpec.describe "Api::V1::Posts", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:group) { FactoryBot.create(:group) }

  describe "#create" do
    it "content are valid" do
      new_post = FactoryBot.build(:post, group: group, user: user)
      expect do
        post api_v1_posts_path, params: {
          group_id: new_post.group_id,
          user_id: new_post.user_id,
          content: new_post.content
        }
      end.to change(Post, :count).by(1)
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["content"]).to eq new_post.content
    end

    it "can't create if content is empty" do
      new_post = FactoryBot.build(:post, :content_is_blank)
      post api_v1_posts_path, params: {
        content: new_post.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "create if content is 300 character" do
      new_post = FactoryBot.build(:post, :three_hundred_char_content, group: group, user: user)
      post api_v1_posts_path, params: {
        group_id: new_post.group_id,
        user_id: new_post.user_id,
        content: new_post.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["content"]).to eq new_post.content
    end

    it "can't create if content is 301 character" do
      new_post = FactoryBot.build(:post, :three_hundred_one_char_content, group: group, user: user)
      post api_v1_posts_path, params: {
        group_id: new_post.group_id,
        user_id: new_post.user_id,
        content: new_post.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end
  end

  describe "#show" do
    let!(:post) { FactoryBot.create(:post, group: group, user: user) }

    it "data exists" do
      get api_v1_post_path(id: post.id)
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["group_id"]).to eq post.group_id
      expect(json["data"]["user_id"]).to eq post.user_id
      expect(json["data"]["content"]).to eq post.content
    end

    it "data does not exist" do
      get api_v1_post_path(id: post.id + 1)
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが存在しません"
    end
  end

  describe "#update" do
    let(:new_group) { FactoryBot.create(:group, :new_group) }
    let(:new_user) { FactoryBot.create(:user, :new_user) }
    let!(:post) { FactoryBot.create(:post, group: group, user: user) }

    it "data exists" do
      new_post = FactoryBot.build(:post, :new_post, group: new_group, user: new_user)
      put api_v1_post_path(id: post.id), params: {
        group_id: new_post.group_id,
        user_id: new_post.user_id,
        content: new_post.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["group_id"]).to eq new_post.group_id
      expect(json["data"]["user_id"]).to eq new_post.user_id
      expect(json["data"]["content"]).to eq new_post.content
    end

    it "data does not exist" do
      new_post = FactoryBot.build(:post, :new_post)
      put api_v1_post_path(id: post.id + 1), params: {
        group_id: post.group_id + 1,
        user_id: post.user_id + 1,
        content: new_post.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが存在しません"
    end

    it "update if content is empty" do
      new_post = FactoryBot.build(:post, :content_is_blank, group: group, user: user)
      put api_v1_post_path(id: post.id), params: {
        group_id: new_post.group_id,
        user_id: new_post.user_id,
        content: new_post.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "update if content is 300 character" do
      new_post = FactoryBot.build(:post, :three_hundred_char_content, group: group, user: user)
      put api_v1_post_path(id: post.id), params: {
        group_id: new_post.group_id,
        user_id: new_post.user_id,
        content: new_post.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["content"]).to eq new_post.content
    end

    it "can't update if content is 301 character" do
      new_post = FactoryBot.build(:post, :three_hundred_one_char_content, group: group, user: user)
      put api_v1_post_path(id: post.id), params: {
        group_id: new_post.group_id,
        user_id: new_post.user_id,
        content: new_post.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end
  end

  describe "#destroy" do
    let!(:post) { FactoryBot.create(:post, group: group, user: user) }

    it "data exists" do
      delete api_v1_post_path(id: post.id)
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["message"]).to eq "削除しました"
      expect(json["data"]["content"]).to eq post.content
    end

    it "data does not exist" do
      delete api_v1_post_path(id: post.id + 1)
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが存在しません"
    end
  end
end
