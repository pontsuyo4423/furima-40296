class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  KATAKANA_REGEXP = /\A[\p{katakana}\u{30fc}]+\z/
  validates :nickname, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: { with: KATAKANA_REGEXP}
  validates :first_name_kana, presence: true, format: { with: KATAKANA_REGEXP}
  validates :birthday, presence: true
  validates :password, format: {
    with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i
  },on: :create
end