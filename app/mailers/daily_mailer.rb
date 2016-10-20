class DailyMailer < ApplicationMailer

  def digest(user)
    @questions = Question.from_yesterday
    mail to: subscriber.email, subject: 'List of all questions from yesterday.'
  end
end
