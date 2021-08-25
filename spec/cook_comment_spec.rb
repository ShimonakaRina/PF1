require 'rails_helper'

describe CookComment do
  describe '#create' do
    
    it "コメント本文がない場合はコメントできないこと" do
      cook_comment = build(:cook_comment, comment: nil)
      cook_comment.valid?
      expect(cook_comment.errors[:comment]).to include("コメントがありません。")
    end
    
    it "評価がない場合はコメントできないこと" do
      cook_comment = build(:cook_comment, rate: nil)
      cook_comment.valid?
      expect(cook_comment.errors[:rate]).to include("評価がありません。")
    end
    
    it "ユーザーIDがない場合はコメントできないこと" do
      cook_comment = build(:cook_comment, user_id: nil)
      cook_comment.valid?
      expect(cook_comment.errors[:user]).to include("ユーザーIDが存在しません。")
    end
    
    it "投稿IDがない場合はコメントできないこと" do
      cook_comment = build(:cook_comment, cook_id: nil)
      cook_comment.valid?
      expect(cook_comment.errors[:cook]).to include("投稿IDが存在しません。")
    end
    
    it "評価が5より高ければコメントできないこと" do
      cook_comment = build(:cook_comment, rate: "6")
      cook_comment.valid?
      expect(cook_comment.errors[:rate]).to include("評価は最大５までです。")
    end
    
    it "評価が5以内であればコメントできること" do
      cook_comment = build(:cook_comment, rate: "4")
      expect(cook_comment).to be_valid
    end
    
    it "評価が0.5未満であればコメントできないこと" do
      cook_comment = build(:cook_comment, rate: "0")
      cook_comment.valid?
      expect(cook_comment.errors[:rate]).to include("最低0.5以上の評価をしてください。")
    end
    
    it "タイトルが0.5以上であればコメントできること" do
      cook_comment = build(:cook_comment, rate: "1")
      expect(cook_comment).to be_valid
    end
    
  end
end