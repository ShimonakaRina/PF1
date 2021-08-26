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

    it "自分の投稿にいいねをした場合、通知確認済みの扱いにする" do
      visiter = create(:user)
      cook = create(:cook, user_id: visiter.id)
      cook.create_notification_by(visiter)
      expect(Notification.where(visited_id: visiter.id, checked: true).count).to eq 1
    end

    it "投稿にコメントしたとき以前にコメントしている人と投稿者をすべて取得し、全員に通知を送る" do
      poster = create(:user, email: "user2@example.com")
      cook = create(:cook, user_id: poster.id)

      first_commenter = create(:user, email: "user3@example.com")
      create(:cook_comment, cook_id: cook.id, user_id: first_commenter.id)

      second_commenter = create(:user)
      second_comment = create(:cook_comment, cook_id: cook.id, user_id: second_commenter.id)

      cook.create_notification_comment!(second_commenter, second_comment.id)

      expect(Notification.where(visited_id: first_commenter.id).count).to eq 1
      expect(Notification.where(visited_id: poster.id).count).to eq 1
    end

    it "コメントは複数回することが考えられるため、１つの投稿に複数回通知する" do
      visiter = create(:user)
      visited = create(:user, email: "user2@example.com")
      cook = create(:cook, user_id: visited.id)

      cook_comment1 = create(:cook_comment, cook_id: cook.id, user_id: visiter.id)
      cook_comment2 = create(:cook_comment, cook_id: cook.id, user_id: visiter.id)

      cook.save_notification_comment!(visiter, cook_comment1.id, visited.id)
      cook.save_notification_comment!(visiter, cook_comment2.id, visited.id)

      expect(Notification.where(visited_id: visited.id).count).to eq 2
    end

    it "自分の投稿にコメントをした場合、通知確認済みの扱いにする" do
      visited = create(:user)
      cook = create(:cook, user_id: visited.id)
      cook_comment = create(:cook_comment, cook_id: cook.id, user_id: visited.id)
      
      cook.save_notification_comment!(visited, cook_comment.id, visited.id)
      
      expect(Notification.where(visited_id: visited.id, checked: true).count).to eq 1
    end

    it "すでに投稿にいいねしているか確認する" do
      user = create(:user)
      cook = create(:cook, user_id: user.id)
      create(:favorite, user_id: user.id, cook_id: cook.id)
      expect(cook.favorited_by?(user)).to be_truthy
    end
    
    it "既にあるタグと同じ名前のタグのついた投稿をしてもタグは統合されるため追加されない" do
      tag = create(:tag, name: "肉")
      cook = create(:cook)
      
      cook.save_tags(["肉"])
      cook.save_tags(["肉"])
      
      expect(Tag.where(name: "肉").count).to eq 1
    end
    
    it "既にあるタグと別の名前のタグのついた投稿をすると新たにタグが作成される。" do
      tag = create(:tag, name: "肉")
      cook = create(:cook)
      
      cook.save_tags(["野菜"])
      cook.save_tags(["魚"])
      
      expect(Tag.count).to eq 3
    end



  end
end