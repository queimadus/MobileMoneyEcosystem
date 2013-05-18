class SessionsController < Devise::SessionsController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }
  respond_to :json

  def create
    resource = User.find_by_email(params[:user][:email])
    if (!resource.is_client?)
     render :json => {:success => false}
    else
    #return invalid_login_attempt unless resource

      if resource.valid_password?(params[:user][:password])
        sign_in(:user, resource)
        resource.ensure_authentication_token!
        render :json=> {:success=>true,:auth_token=>resource.authentication_token}
        return
      end
    end
  end

  def destroy

    if (!current_user.nil?)
      resource = current_user
      resource.authentication_token=nil
      resource.save
      render :json => {:success => true}
    else
      render :json=>{:success=>false, :message=>"No such token"}, :status=>422
    end
  end

  def failure
    render :status => 401,
           :json => { :success => false,
                      :info => "Login Failed",
                      :data => {} }
    end
end
