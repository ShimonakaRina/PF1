require 'rails_helper'

describe Tag do
  describe '#create' do

    it "タグ投稿できること" do
      tag = build(:tag, name: "1234567890")
      expect(tag).to be_valid
    end

 end
end