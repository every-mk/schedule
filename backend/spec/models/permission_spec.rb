require 'rails_helper'

RSpec.describe Permission, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:group) { FactoryBot.create(:group) }

  describe "#create" do
    it "is valid with a user, group, privilege, josin and post" do
      permission = FactoryBot.create(:permission, user: user, group: group)
      expect(permission).to be_valid
    end

    it "is invalid without a user" do
      permission = FactoryBot.build(:permission, group: group)
      permission.valid?
      expect(permission.errors[:user]).to include("must exist")
    end

    it "is invalid without a group" do
      permission = FactoryBot.build(:permission, user: user)
      permission.valid?
      expect(permission.errors[:group]).to include("must exist")
    end

    it "is invalid without a privilege" do
      permission = FactoryBot.build(:permission, :privilege_is_blank, user: user, group: group)
      permission.valid?
      expect(permission.errors[:privilege]).to include("is not included in the list")
    end

    it "invalid if privilege is string" do
      permission = FactoryBot.build(:permission, :privilege_is_string, user: user, group: group)
      permission.valid?
      expect(permission.errors[:privilege]).to include("is not included in the list")
    end

    it "invalid if privilege is 0" do
      permission = FactoryBot.build(:permission, :privilege_is_0, user: user, group: group)
      permission.valid?
      expect(permission.errors[:privilege]).to include("is not included in the list")
    end

    it "valid if privilege is 1" do
      permission = FactoryBot.build(:permission, user: user, group: group)
      permission.valid?
      expect(permission).to be_valid
    end

    it "valid if privilege is 3" do
      permission = FactoryBot.build(:permission, :privilege_is_3, user: user, group: group)
      permission.valid?
      expect(permission).to be_valid
    end

    it "invalid if privilege is 4" do
      permission = FactoryBot.build(:permission, :privilege_is_4, user: user, group: group)
      permission.valid?
      expect(permission.errors[:privilege]).to include("is not included in the list")
    end

    it "is invalid without a join" do
      permission = FactoryBot.build(:permission, :join_is_blank, user: user, group: group)
      permission.valid?
      expect(permission.errors[:join]).to include("is not included in the list")
    end

    it "invalid if join is string" do
      permission = FactoryBot.build(:permission, :join_is_string, user: user, group: group)
      permission.valid?
      expect(permission).to be_valid
      expect(permission.join).to eq true
    end

    it "valid if join is true" do
      permission = FactoryBot.build(:permission, user: user, group: group)
      permission.valid?
      expect(permission).to be_valid
    end

    it "valid if join is false" do
      permission = FactoryBot.build(:permission, :join_is_false, user: user, group: group)
      permission.valid?
      expect(permission).to be_valid
    end

    it "is invalid without a post" do
      permission = FactoryBot.build(:permission, :post_is_blank, user: user, group: group)
      permission.valid?
      expect(permission.errors[:post]).to include("is not included in the list")
    end

    it "invalid if post is string" do
      permission = FactoryBot.build(:permission, :post_is_string, user: user, group: group)
      permission.valid?
      expect(permission).to be_valid
      expect(permission.join).to eq true
    end

    it "valid if post is true" do
      permission = FactoryBot.build(:permission, user: user, group: group)
      permission.valid?
      expect(permission).to be_valid
    end

    it "valid if post is false" do
      permission = FactoryBot.build(:permission, :post_is_false, user: user, group: group)
      permission.valid?
      expect(permission).to be_valid
    end
  end

  describe "#update" do
    let!(:permission) { FactoryBot.create(:permission, user: user, group: group) }

    it "when have not change, it can be updated" do
      permission.valid?
      expect(permission).to be_valid
    end

    it "when change user, group, privilege, join and post, can be updated" do
      new_permission = FactoryBot.build(:permission, :new_permission)
      permission.user = FactoryBot.create(:user, :new_user)
      permission.group = FactoryBot.create(:group, :new_group)
      permission.privilege = new_permission.privilege
      permission.join = new_permission.join
      permission.post = new_permission.post
      permission.valid?
      expect(permission).to be_valid
    end

    it "is invalid without a user" do
      permission.user = nil
      permission.valid?
      expect(permission.errors[:user]).to include("must exist")
    end

    it "is invalid without a group" do
      permission.group = nil
      permission.valid?
      expect(permission.errors[:group]).to include("must exist")
    end

    it "is invalid without a privilege" do
      permission.privilege = nil
      permission.valid?
      expect(permission.errors[:privilege]).to include("is not included in the list")
    end

    it "invalid if privilege is string" do
      permission.privilege = FactoryBot.build(:permission, :privilege_is_string).privilege
      permission.valid?
      expect(permission.errors[:privilege]).to include("is not included in the list")
    end

    it "invalid if privilege is 0" do
      permission.privilege = FactoryBot.build(:permission, :privilege_is_0).privilege
      permission.valid?
      expect(permission.errors[:privilege]).to include("is not included in the list")
    end

    it "valid if privilege is 1" do
      permission.valid?
      expect(permission).to be_valid
    end

    it "valid if privilege is 3" do
      permission.privilege = FactoryBot.build(:permission, :privilege_is_3).privilege
      permission.valid?
      expect(permission).to be_valid
    end

    it "invalid if privilege is 4" do
      permission.privilege = FactoryBot.build(:permission, :privilege_is_4).privilege
      permission.valid?
      expect(permission.errors[:privilege]).to include("is not included in the list")
    end

    it "is invalid without a join" do
      permission.join = nil
      permission.valid?
      expect(permission.errors[:join]).to include("is not included in the list")
    end

    it "invalid if join is string" do
      permission.join = FactoryBot.build(:permission, :join_is_string).join
      permission.valid?
      expect(permission).to be_valid
      expect(permission.join).to eq true
    end

    it "valid if join is true" do
      permission.valid?
      expect(permission).to be_valid
    end

    it "valid if join is false" do
      permission.join = FactoryBot.build(:permission, :join_is_false).join
      permission.valid?
      expect(permission).to be_valid
    end

    it "is invalid without a post" do
      permission.post = nil
      permission.valid?
      expect(permission.errors[:post]).to include("is not included in the list")
    end

    it "invalid if post is string" do
      permission.post = FactoryBot.build(:permission, :post_is_string).post
      permission.valid?
      expect(permission).to be_valid
      expect(permission.join).to eq true
    end

    it "valid if post is true" do
      permission.valid?
      expect(permission).to be_valid
    end

    it "valid if post is false" do
      permission.post = FactoryBot.build(:permission, :post_is_false).post
      permission.valid?
      expect(permission).to be_valid
    end
  end

  describe "#destroy" do
    it "when permission destroy, deleted" do
      permission = FactoryBot.create(:permission, user: user, group: group)
      permission.destroy
      expect(Permission.exists?(id: permission.id)).to be false
      expect(User.exists?(id: user.id)).to be true
      expect(Group.exists?(id: group.id)).to be true
    end

    it "when user destroy, deleted" do
      permission = FactoryBot.create(:permission, user: user, group: group)
      user.destroy
      expect(Permission.exists?(id: permission.id)).to be false
      expect(User.exists?(id: user.id)).to be false
      expect(Group.exists?(id: group.id)).to be true
    end

    it "when group destroy, deleted" do
      permission = FactoryBot.create(:permission, user: user, group: group)
      group.destroy
      expect(Permission.exists?(id: permission.id)).to be false
      expect(User.exists?(id: user.id)).to be true
      expect(Group.exists?(id: group.id)).to be false
    end
  end
end
