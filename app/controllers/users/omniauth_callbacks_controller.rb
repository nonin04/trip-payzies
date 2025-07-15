class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    callback_for(:google)
  end

  def callback_for(provider)
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      # html経由のアクセス時だけflashを表示
      set_flash_message(:notice, :success, kind: provider.to_s.capitalize) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth'].except(:extra)
      redirect_to new_user_registration_url
    end
  end

  def failure
    provider = request.env['omniauth.error.strategy'].name || 'Unknown'
    provider_name = provider.to_s.split('_').first.capitalize
    # html経由のアクセス時だけflashを表示
    set_flash_message( :alert, :failure, kind: provider_name ) if is_navigational_format?
    redirect_to unauthenticated_root_path
  end
end
