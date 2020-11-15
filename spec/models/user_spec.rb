require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it 'nicknameとemail、passwordとpassword_confirmation、last_nameとfirst_name、last_name_kanaとfirst_name_kana、birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordが英数字混合6文字以上であれば登録できる' do
        @user.password = 'abc000'
        @user.password_confirmation = 'abc000'
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複するemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it '@を含まないemailは登録できない' do
        @user.email = 'test.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空だと登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下だと登録できない' do
        @user.password = 'abc12'
        @user.password_confirmation = 'abc12'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordがアルファベットだけだと登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'passwordが数字だけだと登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordとpassword_confirmationの値が一致していないと登録できない' do
        @user.password = 'abc123'
        @user.password_confirmation = '123abc'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'last_nameが空だと登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'first_nameが空だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'last_name_kanaが空だと登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'first_name_kanaが空だと登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'last_nameが半角だと登録できない' do
        @user.last_name = 'ｽｽﾞｷ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name には全角かな/カナ/漢字を使用してください')
      end
      it 'first_nameが半角だと登録できない' do
        @user.first_name = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name には全角かな/カナ/漢字を使用してください')
      end
      it 'last_name_kanaが半角だと登録できない' do
        @user.last_name_kana = 'ｽｽﾞｷ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana には全角カナを使用してください')
      end
      it 'first_name_kanaが半角だと登録できない' do
        @user.first_name_kana = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana には全角カナを使用してください')
      end
      it 'last_nameが全角アルファベットだと登録できない' do
        @user.last_name = 'ＡＢＣ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name には全角かな/カナ/漢字を使用してください')
      end
      it 'first_nameが全角アルファベットだと登録できない' do
        @user.first_name = 'ＥＤＦ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name には全角かな/カナ/漢字を使用してください')
      end
      it 'last_name_kanaが全角アルファベットだと登録できない' do
        @user.last_name_kana = 'ＡＢＣ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana には全角カナを使用してください')
      end
      it 'first_name_kanaが全角アルファベットだと登録できない' do
        @user.first_name_kana = 'ＥＤＦ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana には全角カナを使用してください')
      end
      it 'last_name_kanaが全角漢字だと登録できない' do
        @user.last_name_kana = '鈴木'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana には全角カナを使用してください')
      end
      it 'first_name_kanaが全角漢字だと登録できない' do
        @user.first_name_kana = '太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana には全角カナを使用してください')
      end
      it 'last_name_kanaが全角かなだと登録できない' do
        @user.last_name_kana = 'すずき'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana には全角カナを使用してください')
      end
      it 'first_name_kanaが全角かなだと登録できない' do
        @user.first_name_kana = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana には全角カナを使用してください')
      end
      it 'birthdayが空だと登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
