class User < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  def author_of?(object)
    object.user_id == id
  end

  def voted?(object)
    votes.where(votable: object).exists?
  end
end
