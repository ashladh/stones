class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :real_current_user, :current_user_acting?

  

  protected

  def configure_permitted_parameters
    added_attrs = [:nickname, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end


  private


  # overrides devise
  def current_user
    return @custom_current_user unless @custom_current_user.nil?
    @custom_current_user = if real_current_user && session[:acting_as_user_id]
      @fake_user ||= User.find(session[:acting_as_user_id])
    else
      real_current_user
    end
  end


  def real_current_user
    if @current_user.nil?
      @current_user = warden.authenticate(:scope => :user) || false
    end

    @current_user
  end


  def current_user_acting?
    !session[:acting_as_user_id].nil?
  end


  def render_401 layout = false
    respond_to do |format|
      format.html {
        render file: 'public/401', status: :unauthorized, formats: [:html], layout: layout
      }
      format.js {
        head :unauthorized
      }
    end
  end


  def render_404 layout = false
    respond_to do |format|
      format.html {
        render file: 'public/404', status: :not_found, formats: [:html], layout: layout
      }
      format.js {
        head :not_found
      }
    end
  end

end
