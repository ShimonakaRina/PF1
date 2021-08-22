require 'rails_helper'

describe User do
  describe '#create' do
    # 入力されている場合のテスト ▼

    it "全ての項目の入力が存在すれば登録できること" do # テストしたいことの内容
      user = build(:user)  # 変数userにbuildメソッドを使用して、factory_botのダミーデータを代入
      expect(user).to be_valid # 変数userの情報で登録がされるかどうかのテストを実行
    end

    it "nameがない場合は登録できないこと" do # テストしたいことの内容
      user = build(:user, name: nil) # 変数userにbuildメソッドを使用して、factory_botのダミーデータを代入(今回の場合は意図的にnicknameの値をからに設定)
      user.valid? #バリデーションメソッドを使用して「バリデーションにより保存ができない状態であるか」をテスト
    end

    it "emailがない場合は登録できないこと" do
      user = build(:user, email: nil)
      user.valid?
    end

    it "passwordがない場合は登録できないこと" do
      user = build(:user, password: nil)
      user.valid?
    end

    it "encrypted_passwordがない場合は登録できないこと" do
      user = build(:user, encrypted_password: nil)
      user.valid?
    end

    it "重複したemailが存在する場合登録できないこと" do
      user = create(:user) # createメソッドを使用して変数userとデータベースにfactory_botのダミーデータを保存
      another_user = build(:user, email: user.email) # 2人目のanother_userを変数として作成し、buildメソッドを使用して、意図的にemailの内容を重複させる
      another_user.valid? # another_userの「バリデーションにより保存ができない状態であるか」をテスト
    end

    it "passwordが存在してもencrypted_passwordがない場合は登録できないこと" do
      user = build(:user, encrypted_password: "") # 意図的に確認用パスワードに値を空にする
      user.valid?
    end

    it "passwordが6文字以上であれば登録できること" do
      user = build(:user, password: "123456", encrypted_password: "123456") # buildメソッドを使用して6文字のパスワードを設定
      expect(user).to be_valid
    end

    it "passwordが6文字以下であれば登録できないこと" do
      user = build(:user, password: "12345", encrypted_password: "12345") # 意図的に5文字のパスワードを設定してエラーが出るかをテスト
      user.valid?
    end
    
    it "自己紹介が100文字以上であれば登録できないこと" do
      user = build(:user, introduction: "1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111")
      user.valid?
    end
    
    it "自己紹介が100文字以下であれば登録できること" do
      user = build(:user, introduction: "1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111")
      user.valid?
    end


  end
end