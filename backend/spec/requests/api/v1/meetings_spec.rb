require 'rails_helper'

RSpec.describe "Api::V1::Meetings", type: :request do
  let!(:group) { FactoryBot.create(:group) }

  describe "#create" do
    it "group, name, priority, start_at, end_at, notice period and content are valid" do
      new_meeting = FactoryBot.build(:meeting, group: group)
      expect do
        post api_v1_meetings_path, params: {
          group_id: group.id,
          name: new_meeting.name,
          priority: new_meeting.priority,
          start_at: new_meeting.start_at,
          end_at: new_meeting.end_at,
          notice_period: new_meeting.notice_period,
          content: new_meeting.content
        }
      end.to change(Meeting, :count).by(1)
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["name"]).to eq new_meeting.name
      expect(json["data"]["priority"]).to eq new_meeting.priority
      expect(json["data"]["start_at"]).to eq new_meeting.start_at.iso8601(3)
      expect(json["data"]["end_at"]).to eq new_meeting.end_at.iso8601(3)
      expect(json["data"]["notice_period"]).to eq new_meeting.notice_period
      expect(json["data"]["content"]).to eq new_meeting.content
    end

    it "can't create if group is empty" do
      new_meeting = FactoryBot.build(:meeting)
      post api_v1_meetings_path, params: {
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't create if name is empty" do
      new_meeting = FactoryBot.build(:meeting, group: group)
      post api_v1_meetings_path, params: {
        group_id: new_meeting.group_id,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "create if name is 1 character" do
      new_meeting = FactoryBot.build(:meeting, :one_char_name, group: group)
      post api_v1_meetings_path, params: {
        group_id: new_meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["name"]).to eq new_meeting.name
    end

    it "create if name is 20 character" do
      new_meeting = FactoryBot.build(:meeting, :twenty_char_name, group: group)
      post api_v1_meetings_path, params: {
        group_id: new_meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["name"]).to eq new_meeting.name
    end

    it "can't create if name is 21 character" do
      new_meeting = FactoryBot.build(:meeting, :twenty_one_char_name, group: group)
      post api_v1_meetings_path, params: {
        group_id: new_meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't create if priority is empty" do
      new_meeting = FactoryBot.build(:meeting, group: group)
      post api_v1_meetings_path, params: {
        group_id: new_meeting.group_id,
        name: new_meeting.name,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't create if priority is string" do
      new_meeting = FactoryBot.build(:meeting, :priority_is_string, group: group)
      post api_v1_meetings_path, params: {
        group_id: new_meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't create if priority is 0" do
      new_meeting = FactoryBot.build(:meeting, :priority_is_0, group: group)
      post api_v1_meetings_path, params: {
        group_id: new_meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't create if priority is 1" do
      new_meeting = FactoryBot.build(:meeting, group: group)
      post api_v1_meetings_path, params: {
        group_id: new_meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["priority"]).to eq new_meeting.priority
    end

    it "can't create if priority is 3" do
      new_meeting = FactoryBot.build(:meeting, :priority_is_3, group: group)
      post api_v1_meetings_path, params: {
        group_id: new_meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["priority"]).to eq new_meeting.priority
    end

    it "can't create if priority is 4" do
      new_meeting = FactoryBot.build(:meeting, :priority_is_4, group: group)
      post api_v1_meetings_path, params: {
        group_id: new_meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't create if start_at is empty" do
      new_meeting = FactoryBot.build(:meeting, group: group)
      post api_v1_meetings_path, params: {
        group_id: new_meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't create if start_at is string" do
      new_meeting = FactoryBot.build(:meeting, :start_at_is_string, group: group)
      post api_v1_meetings_path, params: {
        group_id: new_meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't create if end_at is empty" do
      new_meeting = FactoryBot.build(:meeting, group: group)
      post api_v1_meetings_path, params: {
        group_id: new_meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't create if end_at is string" do
      new_meeting = FactoryBot.build(:meeting, :end_at_is_string, group: group)
      post api_v1_meetings_path, params: {
        group_id: new_meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't create if start_at equal end_at" do
      new_meeting = FactoryBot.build(:meeting, :start_at_equal_end_at, group: group)
      post api_v1_meetings_path, params: {
        group_id: new_meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't create if start_at is greater than end_at" do
      new_meeting = FactoryBot.build(:meeting, :start_at_is_greater_than_end_at, group: group)
      post api_v1_meetings_path, params: {
        group_id: new_meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't create if notice period is empty" do
      new_meeting = FactoryBot.build(:meeting, group: group)
      post api_v1_meetings_path, params: {
        group_id: new_meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't create if notice period is string" do
      new_meeting = FactoryBot.build(:meeting, :notice_period_is_string, group: group)
      post api_v1_meetings_path, params: {
        group_id: new_meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["notice_period"]).to eq true
    end

    it "create if notice period is true" do
      new_meeting = FactoryBot.build(:meeting, group: group)
      post api_v1_meetings_path, params: {
        group_id: new_meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["notice_period"]).to eq new_meeting.notice_period
    end

    it "create if notice period is false" do
      new_meeting = FactoryBot.build(:meeting, :notice_period_is_false, group: group)
      post api_v1_meetings_path, params: {
        group_id: new_meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["notice_period"]).to eq new_meeting.notice_period
    end

    it "can't create if content is empty" do
      new_meeting = FactoryBot.build(:meeting, group: group)
      post api_v1_meetings_path, params: {
        group_id: new_meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "create if notice period is 300 character" do
      new_meeting = FactoryBot.build(:meeting, :three_hundred_char_content, group: group)
      post api_v1_meetings_path, params: {
        group_id: new_meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["notice_period"]).to eq new_meeting.notice_period
    end

    it "create if notice period is 301 character" do
      new_meeting = FactoryBot.build(:meeting, :three_hundred_one_char_content, group: group)
      post api_v1_meetings_path, params: {
        group_id: new_meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end
  end

  describe "#show" do
    let!(:meeting) { FactoryBot.create(:meeting, group: group) }

    it "data exists" do
      get api_v1_meeting_path(id: meeting.id)
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["group_id"]).to eq meeting.group_id
      expect(json["data"]["name"]).to eq meeting.name
      expect(json["data"]["priority"]).to eq meeting.priority
      expect(json["data"]["start_at"]).to eq meeting.start_at.iso8601(3)
      expect(json["data"]["end_at"]).to eq meeting.end_at.iso8601(3)
      expect(json["data"]["notice_period"]).to eq meeting.notice_period
      expect(json["data"]["content"]).to eq meeting.content
    end

    it "data does not exist" do
      get api_v1_meeting_path(id: meeting.id + 1)
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが存在しません"
    end
  end

  describe "#update" do
    let(:new_group) { FactoryBot.create(:group, :new_group) }
    let!(:meeting) { FactoryBot.create(:meeting, group: group) }

    it "data exists" do
      put api_v1_meeting_path(id: meeting.id), params: {
        group_id: meeting.group_id,
        name: meeting.name,
        priority: meeting.priority,
        start_at: meeting.start_at,
        end_at: meeting.end_at,
        notice_period: meeting.notice_period,
        content: meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["group_id"]).to eq meeting.group_id
      expect(json["data"]["name"]).to eq meeting.name
      expect(json["data"]["priority"]).to eq meeting.priority
      expect(json["data"]["start_at"]).to eq meeting.start_at.iso8601(3)
      expect(json["data"]["end_at"]).to eq meeting.end_at.iso8601(3)
      expect(json["data"]["notice_period"]).to eq meeting.notice_period
      expect(json["data"]["content"]).to eq meeting.content
    end

    it "meeting does not exist" do
      put api_v1_meeting_path(id: meeting.id + 1), params: {
        group_id: meeting.group_id,
        name: meeting.name,
        priority: meeting.priority,
        start_at: meeting.start_at,
        end_at: meeting.end_at,
        notice_period: meeting.notice_period,
        content: meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが存在しません"
    end

    it "group does not exist" do
      put api_v1_meeting_path(id: meeting.id), params: {
        group_id: meeting.group_id + 1,
        name: meeting.name,
        priority: meeting.priority,
        start_at: meeting.start_at,
        end_at: meeting.end_at,
        notice_period: meeting.notice_period,
        content: meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't update if group is empty" do
      put api_v1_meeting_path(id: meeting.id), params: {
        group_id: nil,
        name: meeting.name,
        priority: meeting.priority,
        start_at: meeting.start_at,
        end_at: meeting.end_at,
        notice_period: meeting.notice_period,
        content: meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't update if name is empty" do
      put api_v1_meeting_path(id: meeting.id), params: {
        group_id: meeting.group_id,
        name: nil,
        priority: meeting.priority,
        start_at: meeting.start_at,
        end_at: meeting.end_at,
        notice_period: meeting.notice_period,
        content: meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "update if name is 1 character" do
      new_meeting = FactoryBot.build(:meeting, :one_char_name)
      put api_v1_meeting_path(id: meeting.id), params: {
        group_id: meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["name"]).to eq new_meeting.name
    end

    it "update if name is 20 character" do
      new_meeting = FactoryBot.build(:meeting, :twenty_char_name)
      put api_v1_meeting_path(id: meeting.id), params: {
        group_id: meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["name"]).to eq new_meeting.name
    end

    it "can't update if name is 21 character" do
      new_meeting = FactoryBot.build(:meeting, :twenty_one_char_name)
      put api_v1_meeting_path(id: meeting.id), params: {
        group_id: meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't update if priority is empty" do
      put api_v1_meeting_path(id: meeting.id), params: {
        group_id: meeting.group_id,
        name: meeting.name,
        priority: nil,
        start_at: meeting.start_at,
        end_at: meeting.end_at,
        notice_period: meeting.notice_period,
        content: meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't update if priority is string" do
      new_meeting = FactoryBot.build(:meeting, :priority_is_string)
      put api_v1_meeting_path(id: meeting.id), params: {
        group_id: meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't update if priority is 0" do
      new_meeting = FactoryBot.build(:meeting, :priority_is_0)
      put api_v1_meeting_path(id: meeting.id), params: {
        group_id: meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "update if priority is 1" do
      new_meeting = FactoryBot.build(:meeting)
      put api_v1_meeting_path(id: meeting.id), params: {
        group_id: meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["priority"]).to eq new_meeting.priority
    end

    it "update if priority is 3" do
      new_meeting = FactoryBot.build(:meeting, :priority_is_3)
      put api_v1_meeting_path(id: meeting.id), params: {
        group_id: meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["priority"]).to eq new_meeting.priority
    end

    it "can't update if priority is 4" do
      new_meeting = FactoryBot.build(:meeting, :priority_is_4)
      put api_v1_meeting_path(id: meeting.id), params: {
        group_id: meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't update if start_at is empty" do
      put api_v1_meeting_path(id: meeting.id), params: {
        group_id: meeting.group_id,
        name: meeting.name,
        priority: meeting.priority,
        start_at: nil,
        end_at: meeting.end_at,
        notice_period: meeting.notice_period,
        content: meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't update if start_at is string" do
      new_meeting = FactoryBot.build(:meeting, :start_at_is_string)
      put api_v1_meeting_path(id: meeting.id), params: {
        group_id: meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't update if end_at is empty" do
      put api_v1_meeting_path(id: meeting.id), params: {
        group_id: meeting.group_id,
        name: meeting.name,
        priority: meeting.priority,
        start_at: meeting.start_at,
        end_at: nil,
        notice_period: meeting.notice_period,
        content: meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't update if end_at is string" do
      new_meeting = FactoryBot.build(:meeting, :end_at_is_string)
      put api_v1_meeting_path(id: meeting.id), params: {
        group_id: meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't update if start_at equal end_at" do
      new_meeting = FactoryBot.build(:meeting, :start_at_equal_end_at)
      put api_v1_meeting_path(id: meeting.id), params: {
        group_id: meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't update if start_at is greater than end_at" do
      new_meeting = FactoryBot.build(:meeting, :start_at_is_greater_than_end_at)
      put api_v1_meeting_path(id: meeting.id), params: {
        group_id: meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't update if notice period is empty" do
      put api_v1_meeting_path(id: meeting.id), params: {
        group_id: meeting.group_id,
        name: meeting.name,
        priority: meeting.priority,
        start_at: meeting.start_at,
        end_at: meeting.end_at,
        notice_period: nil,
        content: meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't update if notice period is string" do
      new_meeting = FactoryBot.build(:meeting, :notice_period_is_string)
      put api_v1_meeting_path(id: meeting.id), params: {
        group_id: meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["notice_period"]).to eq true
    end

    it "update if start_at is true" do
      new_meeting = FactoryBot.build(:meeting)
      put api_v1_meeting_path(id: meeting.id), params: {
        group_id: meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["notice_period"]).to eq new_meeting.notice_period
    end

    it "update if start_at is false" do
      new_meeting = FactoryBot.build(:meeting, :notice_period_is_false)
      put api_v1_meeting_path(id: meeting.id), params: {
        group_id: meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["notice_period"]).to eq new_meeting.notice_period
    end

    it "can't update if content is empty" do
      put api_v1_meeting_path(id: meeting.id), params: {
        group_id: meeting.group_id,
        name: meeting.name,
        priority: meeting.priority,
        start_at: meeting.start_at,
        end_at: meeting.end_at,
        notice_period: meeting.notice_period,
        content: nil
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end

    it "can't update if content is 300 character" do
      new_meeting = FactoryBot.build(:meeting, :three_hundred_char_content)
      put api_v1_meeting_path(id: meeting.id), params: {
        group_id: meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["data"]["content"]).to eq new_meeting.content
    end

    it "can't update if content is 301 character" do
      new_meeting = FactoryBot.build(:meeting, :three_hundred_one_char_content)
      put api_v1_meeting_path(id: meeting.id), params: {
        group_id: meeting.group_id,
        name: new_meeting.name,
        priority: new_meeting.priority,
        start_at: new_meeting.start_at,
        end_at: new_meeting.end_at,
        notice_period: new_meeting.notice_period,
        content: new_meeting.content
      }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが不正です"
    end
  end

  describe "#destroy" do
    let!(:meeting) { FactoryBot.create(:meeting, group: group) }

    it "data exists" do
      delete api_v1_meeting_path(id: meeting.id)
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 200
      expect(json["message"]).to eq "削除しました"
      expect(json["data"]["group_id"]).to eq meeting.group_id
      expect(json["data"]["name"]).to eq meeting.name
      expect(json["data"]["priority"]).to eq meeting.priority
      expect(json["data"]["start_at"]).to eq meeting.start_at.iso8601(3)
      expect(json["data"]["end_at"]).to eq meeting.end_at.iso8601(3)
      expect(json["data"]["notice_period"]).to eq meeting.notice_period
      expect(json["data"]["content"]).to eq meeting.content
    end

    it "data does not exist" do
      delete api_v1_meeting_path(id: meeting.id + 1)
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["status"]).to eq 500
      expect(json["message"]).to eq "データが存在しません"
    end
  end
end
