class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def user_is_client!
      unless current_user.is_client?
          flash[:notice]  =  'Please login into a client account'
          redirect_to  root_path
      end
  end

  def user_is_merchant!
    unless current_user.is_merchant?
        flash[:notice]  =  'Please login into a merchant account'
        redirect_to root_path
    end
  end

  def invalid_params
    render :json => {:success => false, :message => "invalid parameters"}
    false
  end
end
