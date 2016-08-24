class AddUserToQuestionsAndAnswers < ActiveRecord::Migration[5.0]
  def change
    add_reference :questions, :user, index: true, foreign_key: :users
    add_reference :answers, :user, index: true, foreign_key: :users
  end
end
