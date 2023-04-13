class PhotoSubscribersNotifyJob < ApplicationJob
  queue_as :default

  def perform(photo)
    total_emails = (photo.event.subscriptions.map(&:user_email) + [photo.event.user.email] - [photo.user.email]).uniq

    total_emails.each do |mail|
      EventMailer.photo(photo, mail).deliver_now
    end
  end
end
