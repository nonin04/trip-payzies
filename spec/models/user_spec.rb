require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it '名前があれば成功' do
      user = build(:user)
      expect(user).to be_valid
    end

    it '名前がないと失敗' do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
    end

    it 'メールアドレスがないと失敗' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it 'パスワードがないと失敗' do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
    end

    it '名前が31文字だと失敗' do
      user = build(:user, name: 'a' * 31)
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include('は30字以内')
    end

    it 'uidが重複していてもproviderが違えば有効' do
      create(:user, uid: '12345', provider: 'google')
      other = build(:user, email:'test2@email.com', uid: '12345', provider: 'facebook')
      expect(other).to be_valid
    end

    it '同じuidと同じproviderの組み合わせは無効' do
      create(:user, uid: '12345', provider: 'google')
      duplicate = build(:user, uid: '12345', provider: 'google')
      expect(duplicate).not_to be_valid
    end
  end

  describe '.from_omniauthメソッドの検証' do
    ## 遅延評価のインスタンス(auth)を生成
    let(:auth) do
      OmniAuth::AuthHash.new(
        provider: 'google_oauth2',
        uid: '123456',
        info: {
          name: 'Google User',
          email: 'google@example.com'
        }
      )
    end

    it 'ユーザーが存在しない場合は新しく作成される' do
      user = User.from_omniauth(auth)
      expect(user.name).to eq('Google User')
      expect(user.email).to eq('google@example.com')
    end

    it '既に存在する場合は再利用される' do
      existing_user = create(:user, provider: 'google_oauth2', uid: '123456')
      user = User.from_omniauth(auth)
      expect(user).to eq(existing_user)
    end
  end

end
