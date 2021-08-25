require 'rails_helper'

describe Tag do
  describe '#create' do
    
    it "タグ名が11文字以上であれば投稿できないこと" do
      tag = build(:tag, name: "12345678910")
      tag.valid?
      expect(tag.errors[:name]).to include("タグ名は10文字以内で入力してください。")
    end

    it "タグ名が10文字以内であれば投稿できること" do
      tag = build(:tag, name: "1234567890")
      expect(tag).to be_valid
    end

 end
end