class User < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :authorizations

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :twitter]

  def author_of?(object)
    object.user_id == id
  end

  def voted?(object)
    votes.where(votable: object).exists?
  end

  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth[:provider], uid: auth[:uid].to_s).first
    return authorization.user if authorization

    email = auth[info: :email]
    return unless email

    user = User.where(email: email).first
    if user
      user.authorizations.create(provider: auth[:provider], uid: auth[:uid])
    else
      password = Devise.friendly_token[0, 20]
      user = User.create!(email: email, password: password, password_confirmation: password)
      user.authorizations.create(provider: auth[:provider], uid: auth[:uid])
    end
    user
  end
end
