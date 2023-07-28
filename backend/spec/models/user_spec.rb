require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#create" do
    it "is valid with a name, email and password" do
      user = FactoryBot.create(:user)
      expect(user).to be_valid
    end

    it "is invalid without a name" do
      user = FactoryBot.build(:user, :name_is_blank)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it "valid if name is 1 character" do
      user = FactoryBot.create(:user, :one_char_name)
      expect(user).to be_valid
    end
    it "valid if name is 30 character" do
      user = FactoryBot.create(:user, :thirty_char_name)
      expect(user).to be_valid
    end
    it "invalid if name is 31 character" do
      user = FactoryBot.build(:user, :thirty_one_char_name)
      user.valid?
      expect(user.errors[:name]).to include("is too long (maximum is 30 characters)")
    end

    it "is invalid if name exceeds 30" do
      user = User.new(name: "1234567890123456789012345678901")
      user.valid?
      expect(user.errors[:name]).to include("is too long (maximum is 30 characters)")
    end

    it "is invalid without a email address" do
      user = FactoryBot.build(:user, :email_is_blank)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is invalid with a duplicate email address" do
      created_user = FactoryBot.create(:user)
      user = FactoryBot.build(:user)
      user.email = created_user.email
      user.valid?
      expect(user.errors[:email]).to include("has already been taken")
    end

    it "is invalid without a password" do
      user = FactoryBot.build(:user, :password_is_blank)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end
  end
end
