class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: %i[vkontakte github]

  has_many :events
  has_many :comments, dependent: :destroy
  has_many  :subscriptions


  validates :name, presence: true, length: {maximum: 35}

  before_validation :set_name, on: :create

  after_commit :link_subscriptions, on: :create

  mount_uploader :avatar, AvatarUploader

  def self.from_omniauth(access_token)
    user = User.where(email: access_token.info.email).first

    user ||= User.create(
      email: access_token.info.email,
      password: Devise.friendly_token[0, 20],
      name: access_token.info.name,
      provider: access_token.provider,
      uid: access_token.uid
    )

    user
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  private

  def set_name
    self.name = "Товарисч №#{rand(777)}" if self.name.blank?
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email)
    .update_all(user_id: self.id)
  end
end
