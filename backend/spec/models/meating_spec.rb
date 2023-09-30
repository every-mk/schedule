require 'rails_helper'

RSpec.describe Meating, type: :model do
  let(:group) { FactoryBot.create(:group) }

  describe "#create" do
    it "is valid with a group, name, priority, start_at, end_at, notice_period and content" do
      meating = FactoryBot.create(:meating, group: group)
      expect(meating).to be_valid
    end

    it "is invalid without a group" do
      meating = FactoryBot.build(:meating)
      meating.valid?
      expect(meating.errors[:group]).to include("must exist")
    end

    it "is invalid without a name" do
      meating = FactoryBot.build(:meating, :name_is_blank, group: group)
      meating.valid?
      expect(meating.errors[:name]).to include("can't be blank")
    end

    it "valid if name is 1 character" do
      meating = FactoryBot.build(:meating, :one_char_name, group: group)
      meating.valid?
      expect(meating).to be_valid
    end

    it "valid if name is 20 character" do
      meating = FactoryBot.build(:meating, :twenty_char_name, group: group)
      meating.valid?
      expect(meating).to be_valid
    end

    it "invalid if name is 21 character" do
      meating = FactoryBot.build(:meating, :twenty_one_char_name, group: group)
      meating.valid?
      expect(meating.errors[:name]).to include("is too long (maximum is 20 characters)")
    end

    it "is invalid without a priority" do
      meating = FactoryBot.build(:meating, :priority_is_blank, group: group)
      meating.valid?
      expect(meating.errors[:priority]).to include("is not included in the list")
    end

    it "invalid if priority is string" do
      meating = FactoryBot.build(:meating, :priority_is_string, group: group)
      meating.valid?
      expect(meating.errors[:priority]).to include("is not included in the list")
    end

    it "invalid if priority is 0" do
      meating = FactoryBot.build(:meating, :priority_is_0, group: group)
      meating.valid?
      expect(meating.errors[:priority]).to include("is not included in the list")
    end

    it "valid if priority is 1" do
      meating = FactoryBot.build(:meating, group: group)
      meating.valid?
      expect(meating).to be_valid
    end

    it "invalid if priority is 3" do
      meating = FactoryBot.build(:meating, :priority_is_3, group: group)
      meating.valid?
      expect(meating).to be_valid
    end

    it "invalid if priority is 4" do
      meating = FactoryBot.build(:meating, :priority_is_4, group: group)
      meating.valid?
      expect(meating.errors[:priority]).to include("is not included in the list")
    end

    it "with is invalid a start_at" do
      meating = FactoryBot.build(:meating, :start_at_is_blank)
      meating.valid?
      expect(meating.errors[:start_at]).to include("can't be blank")
    end

    it "invalid if start_at is string" do
      meating = FactoryBot.build(:meating, :start_at_is_string, group: group)
      meating.valid?
      expect(meating.errors[:start_at]).to include("can't be blank")
    end

    it "with is invalid a end_at" do
      meating = FactoryBot.build(:meating, :end_at_is_blank, group: group)
      meating.valid?
      expect(meating.errors[:end_at]).to include("can't be blank")
    end

    it "invalid if end_at is string" do
      meating = FactoryBot.build(:meating, :end_at_is_string, group: group)
      meating.valid?
      expect(meating.errors["end_at"]).to include("can't be blank")
    end

    it "invalid is start_at equal end_at" do
      meating = FactoryBot.build(:meating, :start_at_equal_end_at, group: group)
      meating.valid?
      expect(meating.errors[:start_at]).to include("must be less than 2023-09-26 10:00:00 UTC")
      expect(meating.errors[:end_at]).to include("must be greater than 2023-09-26 10:00:00 UTC")
    end

    it "invalid if start_at is greater than end_at" do
      meating = FactoryBot.build(:meating, :start_at_is_greater_than_end_at, group: group)
      meating.valid?
      expect(meating.errors[:start_at]).to include("must be less than 2023-09-26 09:00:00 UTC")
      expect(meating.errors[:end_at]).to include("must be greater than 2023-09-26 10:00:00 UTC")
    end

    it "is invalid without a notice period" do
      meating = FactoryBot.build(:meating, :notice_period_is_blank, group: group)
      meating.valid?
      expect(meating.errors[:notice_period]).to include("is not included in the list")
    end

    it "invalid if notice period is string" do
      meating = FactoryBot.build(:meating, :notice_period_is_string, group: group)
      meating.valid?
      expect(meating.notice_period).to eq true
      expect(meating).to be_valid
    end

    it "valid if notice period is true" do
      meating = FactoryBot.build(:meating, group: group)
      meating.valid?
      expect(meating).to be_valid
    end

    it "valid if notice period is false" do
      meating = FactoryBot.build(:meating, :notice_period_is_false, group: group)
      meating.valid?
      expect(meating).to be_valid
    end

    it "is valid without a content" do
      meating = FactoryBot.build(:meating, :content_is_blank, group: group)
      meating.valid?
      expect(meating.errors[:content]).to include("can't be blank")
    end

    it "valid if content is 300 character" do
      meating = FactoryBot.build(:meating, :three_hundred_char_content, group: group)
      meating.valid?
      expect(meating).to be_valid
    end

    it "valid if content is 301 character" do
      meating = FactoryBot.build(:meating, :three_hundred_one_char_content)
      meating.valid?
      expect(meating.errors[:content]).to include("is too long (maximum is 300 characters)")
    end
  end

  describe "#update" do
    let!(:meating) { FactoryBot.create(:meating, group: group) }

    it "when have not change, it can be updaated" do
      meating.valid?
      expect(meating).to be_valid
    end

    it "when change name, priority, start_at, end_at, notice period and content, can be updated" do
      new_meating = FactoryBot.build(:meating, :new_meating)
      meating.group = FactoryBot.build(:group, :new_group)
      meating.name = new_meating.name
      meating.priority = new_meating.priority
      meating.start_at = new_meating.start_at
      meating.end_at = new_meating.end_at
      meating.notice_period = new_meating.notice_period
      meating.content = new_meating.content
      expect(meating).to be_valid
    end

    it "is invalid without a group" do
      meating.group = nil
      meating.valid?
      expect(meating.errors[:group]).to include("must exist")
    end

    it "is invalid without a name" do
      meating.name = nil
      meating.valid?
      expect(meating.errors[:name]).to include("can't be blank")
    end

    it "when change name, it can be updated" do
      meating.name = FactoryBot.build(:meating, :new_meating).name
      meating.valid?
      expect(meating).to be_valid
    end

    it "valid if name is 1 character" do
      meating.name = FactoryBot.build(:meating, :one_char_name).name
      meating.valid?
      expect(meating).to be_valid
    end

    it "valid if name is 20 character" do
      meating.name = FactoryBot.build(:meating, :twenty_char_name).name
      meating.valid?
      expect(meating).to be_valid
    end

    it "invalid if name is 21 character" do
      meating.name = FactoryBot.build(:meating, :twenty_one_char_name).name
      meating.valid?
      expect(meating.errors[:name]).to include("is too long (maximum is 20 characters)")
    end

    it "is invalid without a priority" do
      meating.priority = nil
      meating.valid?
      expect(meating.errors[:priority]).to include("is not included in the list")
    end

    it "invalid if priprity is 0" do
      meating.priority = FactoryBot.build(:meating, :priority_is_0).priority
      meating.valid?
      expect(meating.errors[:priority]).to include("is not included in the list")
    end

    it "valid if priority is 1" do
      meating.valid?
      expect(meating).to be_valid
    end

    it "valid if priority is 3" do
      meating.priority = FactoryBot.build(:meating, :priority_is_3).priority
      meating.valid?
      expect(meating).to be_valid
    end

    it "invalid if priority is 4" do
      meating.priority = FactoryBot.build(:meating, :priority_is_4).priority
      meating.valid?
      expect(meating.errors[:priority]).to include("is not included in the list")
    end

    it "is invalid without a start_at" do
      meating.start_at = nil
      meating.valid?
      expect(meating.errors[:start_at]).to include("can't be blank")
    end

    it "invalid if start_at is string" do
      meating.start_at = FactoryBot.build(:meating, :start_at_is_string).start_at
      meating.valid?
      expect(meating.errors[:start_at]).to include("can't be blank")
    end

    it "is invalid withot a end_at" do
      meating.end_at = nil
      meating.valid?
      expect(meating.errors[:end_at]).to include("can't be blank")
    end

    it "invalid if end_at is string" do
      meating.end_at = FactoryBot.build(:meating, :end_at_is_string).end_at
      meating.valid?
      expect(meating.errors[:end_at]).to include("can't be blank")
    end

    it "invalid is start_at equal end_at" do
      meating = FactoryBot.build(:meating, :start_at_equal_end_at, group: group)
      meating.valid?
      expect(meating.errors[:start_at]).to include("must be less than 2023-09-26 10:00:00 UTC")
      expect(meating.errors[:end_at]).to include("must be greater than 2023-09-26 10:00:00 UTC")
    end

    it "invalid if start_at is greater than end_at" do
      meating = FactoryBot.build(:meating, :start_at_is_greater_than_end_at, group: group)
      meating.valid?
      expect(meating.errors[:start_at]).to include("must be less than 2023-09-26 09:00:00 UTC")
      expect(meating.errors[:end_at]).to include("must be greater than 2023-09-26 10:00:00 UTC")
    end

    it "is invalid without a notice period" do
      meating.notice_period = nil
      meating.valid?
      expect(meating.errors[:notice_period]).to include("is not included in the list")
    end

    it "valid if notice period is string" do
      meating.notice_period = FactoryBot.build(:meating, :notice_period_is_string).notice_period
      meating.valid?
      expect(meating.notice_period).to eq true
      expect(meating).to be_valid
    end

    it "valid if notice period is true" do
      meating.valid?
      expect(meating).to be_valid
    end

    it "valid if notice period is false" do
      meating.notice_period = FactoryBot.build(:meating, :notice_period_is_false).notice_period
      meating.valid?
      expect(meating).to be_valid
    end

    it "is invalid without a content" do
      meating.content = nil
      meating.valid?
      expect(meating.errors[:content]).to include("can't be blank")
    end

    it "valid if content is 300 character" do
      meating.content = FactoryBot.build(:meating, :three_hundred_char_content).content
      meating.valid?
      expect(meating).to be_valid
    end

    it "invalid if content is 301 character" do
      meating.content = FactoryBot.build(:meating, :three_hundred_one_char_content).content
      meating.valid?
      expect(meating.errors[:content]).to include("is too long (maximum is 300 characters)")
    end
  end

  describe "#destroy" do
    it "when meating destroy, deleted" do
      meating = FactoryBot.create(:meating, group: group)
      meating.destroy
      expect(Meating.exists?(id: meating.id)).to be false
      expect(Group.exists?(id: group.id)).to be true
    end

    it "when group destroy, deleted" do
      meating = FactoryBot.create(:meating, group: group)
      group.destroy
      expect(Meating.exists?(id: meating.id)).to be false
      expect(Group.exists?(id: group.id)).to be false
    end
  end
end
