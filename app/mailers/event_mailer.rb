class EventMailer < ApplicationMailer

  def subscription(subscription)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = subscription.event

    mail to: event.user.email, subject: "#{I18n.t("event_mailer.new_subscription")} #{event.title}"
  end

  def comment(comment, email)
    @comment = comment
    @event = comment.event

    mail to: email, subject: "#{I18n.t("event_mailer.new_comment")} #{event.title}"
  end

  def photo(photo, email)
    @event = photo.event
    @photo = photo

    mail to: email, subject: I18n.t("event_mailer.new_photo")
  end
end
