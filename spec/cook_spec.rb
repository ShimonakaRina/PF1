require 'rails_helper'

describe Cook do
  describe '#create' do

    it "タイトルがない場合は投稿できないこと" do
      cook = build(:cook, title: nil)
      cook.valid?
      expect(cook.errors[:title]).to include("タイトルを入力してください。")
    end

    it "ユーザーIDがない場合は投稿できないこと" do
      cook = build(:cook, user_id: nil)
      cook.valid?
      expect(cook.errors[:user]).to include("ユーザーIDが存在しません。")
    end

    it "レシピがない場合は投稿できないこと" do
      cook = build(:cook, body: nil)
      cook.valid?
      expect(cook.errors[:body]).to include("レシピが存在しません。")
    end

    it "タイトルが31文字以上であれば投稿できないこと" do
      cook = build(:cook, title: "111111111111111111111111111111111111")
      cook.valid?
      expect(cook.errors[:title]).to include("30文字以内で入力してください。")
    end

    it "タイトルが30文字以内であれば投稿できること" do
      cook = build(:cook, title: "1111111111")
      expect(cook).to be_valid
    end

    it "自分じゃない人の投稿にいいねしたとき相手に通知を作成する" do
      visiter = create(:user)
      visited = create(:user, email: "user2@example.com")
      cook = create(:cook, user_id: visited.id)
      expect(cook.create_notification_by(visiter)).to be_truthy
    end
    
    it "投稿にコメントしたときコメントしている人と投稿者をすべて取得し、全員に通知を送る" do
      visiter = create(:user)
      cook = create(:cook)
      cook_comment = create(:cook_comment, cook_id: cook.id)
      expect(cook.create_notification_comment!(visiter, cook_comment.id)).to be_truthy
    end

  end
end