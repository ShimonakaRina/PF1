require 'rails_helper'

describe Cook do
  describe '#create' do
    
    it "タイトルがない場合は登録できないこと" do
      cook = build(:cook, title: nil)
      cook.valid?
    end
    
    it "レシピがない場合は登録できないこと" do
      cook = build(:cook, body: nil)
      cook.valid?
    end
    
    it "タイトルが30文字以上であれば登録できないこと" do
      cook = build(:cook, title: "111111111111111111111111111111111111")
      cook.valid?
    end
    
    it "タイトルが30文字以内であれば登録できること" do
      cook = build(:cook, title: "1111111111")
      expect(cook).to be_valid
    end
    
  end
end