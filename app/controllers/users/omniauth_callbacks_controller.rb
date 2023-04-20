class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def vkontakte
    sign_in_with_oauth('Vkontakte')
  end

  def github
    sign_in_with_oauth('GitHub')
  end

  private

  def sign_in_with_oauth(provider)
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user.persisted?
      flash[:notice] = t('devise.omniauth_callbacks.success', kind: provider)
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:error] = t(
        'devise.omniauth_callbacks.failure',
        kind: provider,
        reason: 'authentication error'
      )
    end
  end
end
