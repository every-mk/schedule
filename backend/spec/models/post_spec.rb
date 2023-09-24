require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:group) { FactoryBot.create(:group) }

  describe "#create" do
    it "is valid with a group, user and content" do
      post = FactoryBot.create(:post, user: user, group: group)
      expect(post).to be_valid
    end

    it "is invalid without a user" do
      post = FactoryBot.build(:post, group: group)
      post.valid?
      expect(post.errors[:user]).to include("must exist")
    end

    it "is invalid without a group" do
      post = FactoryBot.build(:post, user: user)
      post.valid?
      expect(post.errors[:group]).to include("must exist")
    end

    it "is invalid without a content" do
      post = FactoryBot.build(:post, :content_is_blank, user: user, group: group)
      post.valid?
      expect(post.errors[:content]).to include("can't be blank")
    end

    it "valid if content is 1 character" do
      post = FactoryBot.build(:post, :one_char_content, user: user, group: group)
      post.valid?
      expect(post).to be_valid
    end

    it "valid if content is 300 character" do
      post = FactoryBot.build(:post, :three_hundred_char_content, user: user, group: group)
      post.valid?
      expect(post).to be_valid
    end

    it "invalid if content is 301 character" do
      post = FactoryBot.build(:post, :three_hundred_one_char_content, user: user, group: group)
      post.valid?
      expect(post.errors[:content]).to include("is too long (maximum is 300 characters)")
    end
  end

  describe "#update" do
    let!(:post) { FactoryBot.create(:post, user: user, group: group) }

    it "when have not change, it can be updated" do
      post.valid?
      expect(post).to be_valid
    end

    it "is invalid without a space" do
      post.content = nil
      post.valid?
      expect(post.errors[:content]).to include("can't be blank")
    end

    it "when change content, can be updated" do
      post.content = "new content"
      post.valid?
      expect(post).to be_valid
    end

    it "valid if content is 1 character" do
      post.content = FactoryBot.build(:post, :one_char_content).content
      post.valid?
      expect(post).to be_valid
    end

    it "valid if content is 300 character" do
      post.content = FactoryBot.build(:post, :three_hundred_char_content).content
      post.valid?
      expect(post).to be_valid
    end

    it "invalid if content is 301 character" do
      post.content = FactoryBot.build(:post, :three_hundred_one_char_content).content
      post.valid?
      expect(post.errors[:content]).to include("is too long (maximum is 300 characters)")
    end
  end

  describe "#destroy" do
    it "when post destroy, deleted" do
      post = FactoryBot.create(:post, user: user, group: group)
      post.destroy
      expect(Post.exists?(id: post.id)).to be false
      expect(User.exists?(id: user.id)).to be true
      expect(Group.exists?(id: group.id)).to be true
    end
  end
end
