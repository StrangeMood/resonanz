class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :ensure_user
  before_filter :set_locale

  hide_action :current_user
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: cookies.signed[:auth_token]) if cookies[:auth_token]
  end

  def default_url_options(options = {})
    I18n.locale != I18n.default_locale ? {:locale => I18n.locale} : {}
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def ensure_user
    redirect_to(create_identity_path) unless current_user
  end
end
