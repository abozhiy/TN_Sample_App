class User < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :votes, dependent: :destroy

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  def author_of?(object)
    object.user_id == id
  end

  def voted?(object)
    object.votes.where(user: self).exists?
  end
end
