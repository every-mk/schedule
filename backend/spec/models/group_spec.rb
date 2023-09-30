require 'rails_helper'

RSpec.describe Group, type: :model do
  describe "#create" do
    it "is valid with a space, name and content" do
      group = FactoryBot.create(:group)
      expect(group).to be_valid
    end

    it "is invalid without a space" do
      group = FactoryBot.build(:group, :space_is_blank)
      group.valid?
      expect(group.errors[:space]).to include("can't be blank")
    end

    it "is invalid without a name" do
      group = FactoryBot.build(:group, :name_is_blank)
      group.valid?
      expect(group.errors[:name]).to include("can't be blank")
    end

    it "valid if name is 1 character" do
      group = FactoryBot.build(:group, :one_char_name)
      group.valid?
      expect(group).to be_valid
    end

    it "valid if name is 20 character" do
      group = FactoryBot.build(:group, :twenty_char_name)
      group.valid?
      expect(group).to be_valid
    end

    it "invalid if name is 21 character" do
      group = FactoryBot.build(:group, :twenty_one_char_name)
      group.valid?
      expect(group.errors[:name]).to include("is too long (maximum is 20 characters)")
    end

    it "is valid without a content" do
      group = FactoryBot.build(:group, :content_is_blank)
      group.valid?
      expect(group).to be_valid
    end

    it "valid if content is 300 character" do
      group = FactoryBot.build(:group, :three_hundred_char_content)
      group.valid?
      expect(group).to be_valid
    end

    it "invalid if content is 301 character" do
      group = FactoryBot.build(:group, :three_hundred_one_char_content)
      group.valid?
      expect(group.errors[:content]).to include("is too long (maximum is 300 characters)")
    end
  end

  describe "#update" do
    let!(:group) { FactoryBot.create(:group) }

    it "when have not change, it can be updated" do
      group.valid?
      expect(group).to be_valid
    end

    it "when change space, name and content, can be updated" do
      group.space = "2"
      group.name = "new name"
      group.content = "new content"
      group.valid?
      expect(group).to be_valid
    end

    it "is invalid without a space" do
      group.space = nil
      group.valid?
      expect(group.errors[:space]).to include("can't be blank")
    end

    it "when change space, it can be updated" do
      group.space = 2
      group.valid?
      expect(group).to be_valid
    end

    it "is invalid without a name" do
      group.name = nil
      group.valid?
      expect(group.errors[:name]).to include("can't be blank")
    end

    it "when change name, it can be updated" do
      group.name = "new name"
      group.valid?
      expect(group).to be_valid
    end

    it "valid if name is 1 character" do
      group.name = FactoryBot.build(:group, :one_char_name).name
      group.valid?
      expect(group).to be_valid
    end

    it "valid if name is 20 character" do
      group.name = FactoryBot.build(:group, :twenty_char_name).name
      group.valid?
      expect(group).to be_valid
    end

    it "invalid if name is 21 character" do
      group.name = FactoryBot.build(:group, :twenty_one_char_name).name
      group.valid?
      expect(group.errors[:name]).to include("is too long (maximum is 20 characters)")
    end

    it "is valid without a content" do
      group.content = nil
      group.valid?
      expect(group).to be_valid
    end

    it "when change content, it can be updated" do
      group.content = "new content"
      group.valid?
      expect(group).to be_valid
    end

    it "valid if content is 300 character" do
      group.content = FactoryBot.build(:group, :three_hundred_char_content).content
      group.valid?
      expect(group).to be_valid
    end

    it "invalid if content is 301 character" do
      group.content = FactoryBot.build(:group, :three_hundred_one_char_content).content
      group.valid?
      expect(group.errors[:content]).to include("is too long (maximum is 300 characters)")
    end
  end

  describe "#destroy" do
    it "when group destroy, deleted" do
      group = FactoryBot.create(:group)
      group.destroy
      expect(Group.exists?(id: group.id)).to be false
    end
  end
end
