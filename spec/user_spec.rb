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
      expect(user.errors[:name]).to include("入力してください。") # errorsメソッドを使用して、「バリデーションにより保存ができない状態である場合なぜできないのか」を確認し、.to include("を入力してください")でエラー文を記述(今回のRailsを日本語化しているのでエラー文も日本語)
    end

    it "emailがない場合は登録できないこと" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("入力してください。")
    end

    it "passwordがない場合は登録できないこと" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("入力してください。")
    end

    it "encrypted_passwordがない場合は登録できないこと" do
      user = build(:user, encrypted_password: nil)
      user.valid?
      expect(user.errors[:encrypted_password]).to include("入力してください。")
    end

    it "重複したemailが存在する場合登録できないこと" do
      user = create(:user) # createメソッドを使用して変数userとデータベースにfactory_botのダミーデータを保存
      another_user = build(:user, email: user.email) # 2人目のanother_userを変数として作成し、buildメソッドを使用して、意図的にemailの内容を重複させる
      another_user.valid? # another_userの「バリデーションにより保存ができない状態であるか」をテスト
      expect(another_user.errors[:email]).to include("既に登録済みです。")
    end

    it "passwordが存在してもencrypted_passwordがない場合は登録できないこと" do
      user = build(:user, password: "password", encrypted_password: nil) # 意図的に確認用パスワードに値を空にする
      user.valid?
      expect(user.errors[:encrypted_password]).to include("入力してください。")
    end

    it "passwordが6文字以上であれば登録できること" do
      user = build(:user, password: "123456", encrypted_password: "123456") # buildメソッドを使用して6文字のパスワードを設定
      expect(user).to be_valid
    end

    it "passwordが6文字以下であれば登録できないこと" do
      user = build(:user, password: "12345", encrypted_password: "12345") # 意図的に5文字のパスワードを設定してエラーが出るかをテスト
      user.valid?
      expect(user.errors[:password]).to include("6文字以上で登録してください。")
    end

    it "名前が20文字より多ければ登録できないこと" do
      user = build(:user, name: "123456789123456789101")
      user.valid?
      expect(user.errors[:name]).to include("２０文字以内で入力してください。")
    end

    it "名前が２０文字以上であれば登録できること" do
      user = build(:user, name: "123456")
      expect(user).to be_valid
    end

    it "自己紹介が100文字以上であれば登録できないこと" do
      user = build(:user, introduction: "11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111")
      user.valid?
      expect(user.errors[:introduction]).to include("100文字以上で入力してください")
    end

    it "自己紹介が100文字以下であれば登録できること" do
      user = build(:user, introduction: "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111")
      expect(user).to be_valid
    end


  end
end