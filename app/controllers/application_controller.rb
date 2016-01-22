class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

helper_method :admin?
helper_method :signed_in?

private

  def admin?
    if current_user && current_user.admin?
        return true
    else
      return false
    end
  end

  def signed_in?
    if current_user
        return true
    else
      return false
    end
  end

end
