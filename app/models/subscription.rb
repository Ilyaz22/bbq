class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true

  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, unless: -> { user.present? }

  validates :user, uniqueness: {scope: :event_id}, if: -> { user.present? }
  validates :user_email, uniqueness: {scope: :event_id}, unless: -> { user.present? }

  validate :self_subscription_ban, on: :create
  validate :email_exists, unless: -> {user.present?}

  def user_name
    if user.present?
      user.name
    else
     super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  private

  def self_subscription_ban
    if event.user == user
      errors.add(:base, I18n.t('errors.self_subscription_ban'))
    end
  end

  def email_exists
    if User.find_by(email: user_email)
      errors.add(:base, I18n.t('errors.email_error'))
    end
  end
end
