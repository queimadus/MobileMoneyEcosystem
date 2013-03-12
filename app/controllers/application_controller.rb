class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  def user_is_client!
      unless current_user.is_client?
          flash[:notice]  =  'Please login'
          redirect_to  new_user_session_path
      end
  end

  def user_is_merchant!
    unless current_user.is_merchant?
        flash[:notice]  =  'Please login'
        redirect_to login_path
    end
  end
end
