require 'rails_helper'

describe Relationship do
  describe '#create' do

    it "フォローIDがない場合はフォローできないこと" do
      user = create(:user)
      follow = build(:relationship, follower_id: nil, followed_id: user.id)
      follow.valid?
      expect(follow.errors[:follower]).to include("フォローIDが存在しません。")
    end

    it "フォロワーIDがない場合はフォローされないこと" do
      user = create(:user)
      followed = build(:relationship, followed_id: nil, follower_id: user.id)
      followed.valid?
      expect(followed.errors[:followed]).to include("フォロワーIDが存在しません。")
    end

  end
end