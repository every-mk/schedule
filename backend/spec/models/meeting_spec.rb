require 'rails_helper'

RSpec.describe Meeting, type: :model do
  let(:group) { FactoryBot.create(:group) }

  describe "#create" do
    it "is valid with a group, name, priority, start_at, end_at, notice_period and content" do
      meeting = FactoryBot.create(:meeting, group: group)
      expect(meeting).to be_valid
    end

    it "is invalid without a group" do
      meeting = FactoryBot.build(:meeting)
      meeting.valid?
      expect(meeting.errors[:group]).to include("must exist")
    end

    it "is invalid without a name" do
      meeting = FactoryBot.build(:meeting, :name_is_blank, group: group)
      meeting.valid?
      expect(meeting.errors[:name]).to include("can't be blank")
    end

    it "valid if name is 1 character" do
      meeting = FactoryBot.build(:meeting, :one_char_name, group: group)
      meeting.valid?
      expect(meeting).to be_valid
    end

    it "valid if name is 20 character" do
      meeting = FactoryBot.build(:meeting, :twenty_char_name, group: group)
      meeting.valid?
      expect(meeting).to be_valid
    end

    it "invalid if name is 21 character" do
      meeting = FactoryBot.build(:meeting, :twenty_one_char_name, group: group)
      meeting.valid?
      expect(meeting.errors[:name]).to include("is too long (maximum is 20 characters)")
    end

    it "is invalid without a priority" do
      meeting = FactoryBot.build(:meeting, :priority_is_blank, group: group)
      meeting.valid?
      expect(meeting.errors[:priority]).to include("is not included in the list")
    end

    it "invalid if priority is string" do
      meeting = FactoryBot.build(:meeting, :priority_is_string, group: group)
      meeting.valid?
      expect(meeting.errors[:priority]).to include("is not included in the list")
    end

    it "invalid if priority is 0" do
      meeting = FactoryBot.build(:meeting, :priority_is_0, group: group)
      meeting.valid?
      expect(meeting.errors[:priority]).to include("is not included in the list")
    end

    it "valid if priority is 1" do
      meeting = FactoryBot.build(:meeting, group: group)
      meeting.valid?
      expect(meeting).to be_valid
    end

    it "invalid if priority is 3" do
      meeting = FactoryBot.build(:meeting, :priority_is_3, group: group)
      meeting.valid?
      expect(meeting).to be_valid
    end

    it "invalid if priority is 4" do
      meeting = FactoryBot.build(:meeting, :priority_is_4, group: group)
      meeting.valid?
      expect(meeting.errors[:priority]).to include("is not included in the list")
    end

    it "with is invalid a start_at" do
      meeting = FactoryBot.build(:meeting, :start_at_is_blank)
      meeting.valid?
      expect(meeting.errors[:start_at]).to include("can't be blank")
    end

    it "invalid if start_at is string" do
      meeting = FactoryBot.build(:meeting, :start_at_is_string, group: group)
      meeting.valid?
      expect(meeting.errors[:start_at]).to include("can't be blank")
    end

    it "with is invalid a end_at" do
      meeting = FactoryBot.build(:meeting, :end_at_is_blank, group: group)
      meeting.valid?
      expect(meeting.errors[:end_at]).to include("can't be blank")
    end

    it "invalid if end_at is string" do
      meeting = FactoryBot.build(:meeting, :end_at_is_string, group: group)
      meeting.valid?
      expect(meeting.errors["end_at"]).to include("can't be blank")
    end

    it "invalid is start_at equal end_at" do
      meeting = FactoryBot.build(:meeting, :start_at_equal_end_at, group: group)
      meeting.valid?
      expect(meeting.errors[:start_at]).to include("must be less than 2023-09-26 10:00:00 UTC")
      expect(meeting.errors[:end_at]).to include("must be greater than 2023-09-26 10:00:00 UTC")
    end

    it "invalid if start_at is greater than end_at" do
      meeting = FactoryBot.build(:meeting, :start_at_is_greater_than_end_at, group: group)
      meeting.valid?
      expect(meeting.errors[:start_at]).to include("must be less than 2023-09-26 09:00:00 UTC")
      expect(meeting.errors[:end_at]).to include("must be greater than 2023-09-26 10:00:00 UTC")
    end

    it "is invalid without a notice period" do
      meeting = FactoryBot.build(:meeting, :notice_period_is_blank, group: group)
      meeting.valid?
      expect(meeting.errors[:notice_period]).to include("is not included in the list")
    end

    it "invalid if notice period is string" do
      meeting = FactoryBot.build(:meeting, :notice_period_is_string, group: group)
      meeting.valid?
      expect(meeting.notice_period).to eq true
      expect(meeting).to be_valid
    end

    it "valid if notice period is true" do
      meeting = FactoryBot.build(:meeting, group: group)
      meeting.valid?
      expect(meeting).to be_valid
    end

    it "valid if notice period is false" do
      meeting = FactoryBot.build(:meeting, :notice_period_is_false, group: group)
      meeting.valid?
      expect(meeting).to be_valid
    end

    it "is valid without a content" do
      meeting = FactoryBot.build(:meeting, :content_is_blank, group: group)
      meeting.valid?
      expect(meeting.errors[:content]).to include("can't be blank")
    end

    it "valid if content is 300 character" do
      meeting = FactoryBot.build(:meeting, :three_hundred_char_content, group: group)
      meeting.valid?
      expect(meeting).to be_valid
    end

    it "valid if content is 301 character" do
      meeting = FactoryBot.build(:meeting, :three_hundred_one_char_content)
      meeting.valid?
      expect(meeting.errors[:content]).to include("is too long (maximum is 300 characters)")
    end
  end

  describe "#update" do
    let!(:meeting) { FactoryBot.create(:meeting, group: group) }

    it "when have not change, it can be updaated" do
      meeting.valid?
      expect(meeting).to be_valid
    end

    it "when change name, priority, start_at, end_at, notice period and content, can be updated" do
      new_meeting = FactoryBot.build(:meeting, :new_meeting)
      meeting.group = FactoryBot.build(:group, :new_group)
      meeting.name = new_meeting.name
      meeting.priority = new_meeting.priority
      meeting.start_at = new_meeting.start_at
      meeting.end_at = new_meeting.end_at
      meeting.notice_period = new_meeting.notice_period
      meeting.content = new_meeting.content
      expect(meeting).to be_valid
    end

    it "is invalid without a group" do
      meeting.group = nil
      meeting.valid?
      expect(meeting.errors[:group]).to include("must exist")
    end

    it "is invalid without a name" do
      meeting.name = nil
      meeting.valid?
      expect(meeting.errors[:name]).to include("can't be blank")
    end

    it "when change name, it can be updated" do
      meeting.name = FactoryBot.build(:meeting, :new_meeting).name
      meeting.valid?
      expect(meeting).to be_valid
    end

    it "valid if name is 1 character" do
      meeting.name = FactoryBot.build(:meeting, :one_char_name).name
      meeting.valid?
      expect(meeting).to be_valid
    end

    it "valid if name is 20 character" do
      meeting.name = FactoryBot.build(:meeting, :twenty_char_name).name
      meeting.valid?
      expect(meeting).to be_valid
    end

    it "invalid if name is 21 character" do
      meeting.name = FactoryBot.build(:meeting, :twenty_one_char_name).name
      meeting.valid?
      expect(meeting.errors[:name]).to include("is too long (maximum is 20 characters)")
    end

    it "is invalid without a priority" do
      meeting.priority = nil
      meeting.valid?
      expect(meeting.errors[:priority]).to include("is not included in the list")
    end

    it "invalid if priprity is 0" do
      meeting.priority = FactoryBot.build(:meeting, :priority_is_0).priority
      meeting.valid?
      expect(meeting.errors[:priority]).to include("is not included in the list")
    end

    it "valid if priority is 1" do
      meeting.valid?
      expect(meeting).to be_valid
    end

    it "valid if priority is 3" do
      meeting.priority = FactoryBot.build(:meeting, :priority_is_3).priority
      meeting.valid?
      expect(meeting).to be_valid
    end

    it "invalid if priority is 4" do
      meeting.priority = FactoryBot.build(:meeting, :priority_is_4).priority
      meeting.valid?
      expect(meeting.errors[:priority]).to include("is not included in the list")
    end

    it "is invalid without a start_at" do
      meeting.start_at = nil
      meeting.valid?
      expect(meeting.errors[:start_at]).to include("can't be blank")
    end

    it "invalid if start_at is string" do
      meeting.start_at = FactoryBot.build(:meeting, :start_at_is_string).start_at
      meeting.valid?
      expect(meeting.errors[:start_at]).to include("can't be blank")
    end

    it "is invalid withot a end_at" do
      meeting.end_at = nil
      meeting.valid?
      expect(meeting.errors[:end_at]).to include("can't be blank")
    end

    it "invalid if end_at is string" do
      meeting.end_at = FactoryBot.build(:meeting, :end_at_is_string).end_at
      meeting.valid?
      expect(meeting.errors[:end_at]).to include("can't be blank")
    end

    it "invalid is start_at equal end_at" do
      meeting = FactoryBot.build(:meeting, :start_at_equal_end_at, group: group)
      meeting.valid?
      expect(meeting.errors[:start_at]).to include("must be less than 2023-09-26 10:00:00 UTC")
      expect(meeting.errors[:end_at]).to include("must be greater than 2023-09-26 10:00:00 UTC")
    end

    it "invalid if start_at is greater than end_at" do
      meeting = FactoryBot.build(:meeting, :start_at_is_greater_than_end_at, group: group)
      meeting.valid?
      expect(meeting.errors[:start_at]).to include("must be less than 2023-09-26 09:00:00 UTC")
      expect(meeting.errors[:end_at]).to include("must be greater than 2023-09-26 10:00:00 UTC")
    end

    it "is invalid without a notice period" do
      meeting.notice_period = nil
      meeting.valid?
      expect(meeting.errors[:notice_period]).to include("is not included in the list")
    end

    it "valid if notice period is string" do
      meeting.notice_period = FactoryBot.build(:meeting, :notice_period_is_string).notice_period
      meeting.valid?
      expect(meeting.notice_period).to eq true
      expect(meeting).to be_valid
    end

    it "valid if notice period is true" do
      meeting.valid?
      expect(meeting).to be_valid
    end

    it "valid if notice period is false" do
      meeting.notice_period = FactoryBot.build(:meeting, :notice_period_is_false).notice_period
      meeting.valid?
      expect(meeting).to be_valid
    end

    it "is invalid without a content" do
      meeting.content = nil
      meeting.valid?
      expect(meeting.errors[:content]).to include("can't be blank")
    end

    it "valid if content is 300 character" do
      meeting.content = FactoryBot.build(:meeting, :three_hundred_char_content).content
      meeting.valid?
      expect(meeting).to be_valid
    end

    it "invalid if content is 301 character" do
      meeting.content = FactoryBot.build(:meeting, :three_hundred_one_char_content).content
      meeting.valid?
      expect(meeting.errors[:content]).to include("is too long (maximum is 300 characters)")
    end
  end

  describe "#destroy" do
    it "when meeting destroy, deleted" do
      meeting = FactoryBot.create(:meeting, group: group)
      meeting.destroy
      expect(Meeting.exists?(id: meeting.id)).to be false
      expect(Group.exists?(id: group.id)).to be true
    end

    it "when group destroy, deleted" do
      meeting = FactoryBot.create(:meeting, group: group)
      group.destroy
      expect(Meeting.exists?(id: meeting.id)).to be false
      expect(Group.exists?(id: group.id)).to be false
    end
  end
end
