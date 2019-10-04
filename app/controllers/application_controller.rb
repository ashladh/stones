class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:nickname, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end


  private


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
