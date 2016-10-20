class AnswerNoticeMailer < ApplicationMailer

  def new_answer_notice(subscriber)
    mail to: subscriber.email, subject: 'Somebody gave answer to your question.'
  end
end
