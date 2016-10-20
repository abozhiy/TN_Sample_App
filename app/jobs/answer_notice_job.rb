class AnswerNoticeJob < ApplicationJob
  queue_as :default

  def perform(answer)
    answer.question.subscribers.each do |subscriber|
      AnswerNoticeMailer.new_answer_notice(subscriber).deliver_later
    end
  end
end
