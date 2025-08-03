class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale


  def after_sign_in_path_for(resource)
    trips_path
  end

  def after_sign_up_path_for(resource)
    trips_path
  end

  private

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
  end

  def set_locale
    locale = extract_locale_from_accept_language_header
    if %w[en ja].include?(locale)
      I18n.locale = locale
    else
      I18n.locale = :ja
    end
  end

  def extract_locale_from_accept_language_header
    request.env["HTTP_ACCEPT_LANGUAGE"]&.scan(/^[a-z]{2}/)&.first
  end
end
