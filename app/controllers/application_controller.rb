class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    def current_perfil
      @current_perfil ||= Perfil.find(session[:perfil_id]) if session[:perfil_id]
    end
    helper_method :current_perfil

    def authorize
      redirect_to 'login_path' unless current_perfil
    end
end