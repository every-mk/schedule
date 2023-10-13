require 'rails_helper'

RSpec.describe Invite, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:group) { FactoryBot.create(:group) }
  let(:meeting) { FactoryBot.create(:meeting, group: group) }

  describe "#create" do
    it "is valid with a meeting, user and kind" do
      invite = FactoryBot.create(:invite, meeting: meeting, user: user)
      expect(invite).to be_valid
    end

    it "is invalid without a meeting" do
      invite = FactoryBot.build(:invite, user: user)
      invite.valid?
      expect(invite.errors[:meeting]).to include("must exist")
    end

    it "is invalid without a user" do
      invite = FactoryBot.build(:invite, meeting: meeting)
      invite.valid?
      expect(invite.errors[:user]).to include("must exist")
    end

    it "is invalid without a kind" do
      invite = FactoryBot.build(:invite, :kind_is_blank, meeting: meeting, user: user)
      invite.valid?
      expect(invite.errors[:kind]).to include("is not included in the list")
    end

    it "invalid if kind is string" do
      invite = FactoryBot.build(:invite, :kind_is_string, meeting: meeting, user: user)
      invite.valid?
      expect(invite.errors[:kind]).to include("is not included in the list")
    end

    it "invalid if kind is 0" do
      invite = FactoryBot.build(:invite, :kind_is_0, meeting: meeting, user: user)
      invite.valid?
      expect(invite.errors[:kind]).to include("is not included in the list")
    end

    it "valid if kind is 3" do
      invite = FactoryBot.build(:invite, :kind_is_3, meeting: meeting, user: user)
      invite.valid?
      expect(invite).to be_valid
    end

    it "invalid if kind is 4" do
      invite = FactoryBot.build(:invite, :kind_is_4, meeting: meeting, user: user)
      invite.valid?
      expect(invite.errors[:kind]).to include("is not included in the list")
    end
  end

  describe "#update" do
    let!(:invite) { FactoryBot.create(:invite, meeting: meeting, user: user) }

    it "when have not change, it can be updated" do
      invite.valid?
      expect(invite).to be_valid
    end

    it "when change meeting, user and kind, can be updated" do
      new_invite = FactoryBot.build(:invite, :new_invite)
      new_group = FactoryBot.create(:group, :new_group)
      invite.meeting = FactoryBot.create(:meeting, :new_meeting, group: new_group)
      invite.user = FactoryBot.create(:user, :new_user)
      invite.kind = new_invite.kind
      expect(invite).to be_valid
    end

    it "is invalid without a meeting" do
      invite.meeting = nil
      invite.valid?
      expect(invite.errors[:meeting]).to include("must exist")
    end

    it "is invalid without a user" do
      invite.user = nil
      invite.valid?
      expect(invite.errors[:user]).to include("must exist")
    end

    it "is invalid without a kind" do
      invite.kind = nil
      invite.valid?
      expect(invite.errors[:kind]).to include("is not included in the list")
    end

    it "invalid if kind is string" do
      invite.kind = FactoryBot.build(:invite, :kind_is_string).kind
      invite.valid?
      expect(invite.errors[:kind]).to include("is not included in the list")
    end

    it "invalid if kind is 0" do
      invite.kind = FactoryBot.build(:invite, :kind_is_0).kind
      invite.valid?
      expect(invite.errors[:kind]).to include("is not included in the list")
    end

    it "valid if kind is 1" do
      invite.valid?
      expect(invite).to be_valid
    end

    it "valid if kind is 3" do
      invite.kind = FactoryBot.build(:invite, :kind_is_3).kind
      invite.valid?
      expect(invite).to be_valid
    end

    it "invalid if kind is 4" do
      invite.kind = FactoryBot.build(:invite, :kind_is_4).kind
      invite.valid?
      expect(invite.errors[:kind]).to include("is not included in the list")
    end
  end

  describe "#destroy" do
    let!(:invite) { FactoryBot.create(:invite, meeting: meeting, user: user) }

    it "when incite destroy, deleted" do
      invite.destroy
      expect(Invite.exists?(id: invite.id)).to be false
      expect(Meeting.exists?(id: meeting.id)).to be true
      expect(User.exists?(id: user.id)).to be true
    end

    it "when meeting destroy, deleted" do
      meeting.destroy
      expect(Invite.exists?(id: invite.id)).to be false
      expect(Meeting.exists?(id: meeting.id)).to be false
      expect(User.exists?(id: user.id)).to be true
    end

    it "when user destroy, deleted" do
      user.destroy
      expect(Invite.exists?(id: invite.id)).to be false
      expect(Meeting.exists?(id: meeting.id)).to be true
      expect(User.exists?(id: user.id)).to be false
    end
  end
end
