class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_one :purchase

  validates :nickname, presence: true

  with_options presence: true do
    validates :first_name
    validates :last_name
  end

  with_options format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'には全角かな/カナ/漢字を使用してください' }, allow_blank: true do
    validates :first_name
    validates :last_name
  end

  with_options presence: true do
    validates :first_name_kana
    validates :last_name_kana
  end

  with_options format: { with: /\A[ァ-ン]+\z/, message: 'には全角カナを使用してください' }, allow_blank: true do
    validates :first_name_kana
    validates :last_name_kana
  end

  validates :birthday, presence: true

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'
end
