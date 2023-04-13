class CommentSubscribersNotifyJob < ApplicationJob
  queue_as :default

  def perform(comment)
    all_emails = (comment.event.subscriptions.map(&:user_email) + [comment.event.user.email] - [comment.user&.email]).uniq

    all_emails.each do |mail|
      EventMailer.comment(comment, mail).deliver_now
    end
  end
end
