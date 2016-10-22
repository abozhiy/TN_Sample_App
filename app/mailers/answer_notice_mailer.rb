class AnswerNoticeMailer < ApplicationMailer

  def new_answer_notice(subscriber, answer)
    @question = answer.question
    mail to: subscriber.email, subject: 'Your question was answered'
  end
end
