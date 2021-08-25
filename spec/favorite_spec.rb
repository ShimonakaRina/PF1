require 'rails_helper'

describe Favorite do
  describe '#create' do
    
    it "ユーザーIDがない場合はいいねできないこと" do
      favorite = build(:favorite, user_id: nil)
      favorite.valid?
      expect(favorite.errors[:user]).to include("ユーザーIDが存在しません。")
    end
    
    it "投稿IDがない場合はいいねできないこと" do
      favorite = build(:favorite, cook_id: nil)
      favorite.valid?
      expect(favorite.errors[:cook]).to include("投稿IDが存在しません。")
    end
    
  end
end