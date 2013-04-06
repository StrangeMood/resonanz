class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  before_filter :ensure_user
  before_filter :set_locale

  hide_action :current_user
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: cookies.signed[:id]) if cookies[:id]
  end

  def default_url_options(options = {})
    {locale: I18n.locale != I18n.default_locale ? I18n.locale : nil}
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  # open this method for models serialisation to json
  def render_for_api model
    if model.respond_to?(:each)
      # try to find collection template
      collection_name = model.first.class.model_name.collection

      render_to_string(partial: "api/#{collection_name}.json", locals: {collection_name.to_sym => model}) rescue
          "[#{model.map(&method(:render_for_api)).join(',')}]"
    else
      render_to_string(model)
    end
  end
  helper_method :render_for_api

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def ensure_user
    redirect_to(create_identity_path) unless current_user
  end
end