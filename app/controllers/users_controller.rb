class UsersController < ApplicationController
  before_filter :authenticate_user!


  def header_info

    if current_user.is_client?
       name = current_user.client.first_name+" "+current_user.client.last_name
       credit = current_user.client.credit
    else
      name = current_user.merchant.name
      credit = current_user.merchant.credit
    end
      url = current_user.avatar.url

     respond_to do |format|
       format.json { render json: {:name => name, :credit => credit, :image_url => url}}
     end
  end

  def update

    @user = User.find(current_user.id)
    if params[:user][:avatar]
      name = "Avatar"
      partial = 'settings/avatar_form'
    elsif params[:user][:email]
      name = "Email"
      partial = 'settings/email_form'
    end

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.json { render json: {:success => true,
                                    :html => render_to_string( :partial => partial,
                                                               :locals => {:resource => @user}),
                                    :notice => name+" updated"}}

        format.html { redirect_to settings_path, notice: name+" updated" }
      else
        format.json { render json: {:success => false,
                                    :html => render_to_string( :partial => partial,
                                                               :locals => {:resource => @user}),
                                    :notice => name+" not updated"}}

        format.html { redirect_to settings_path, error: name+" not updated" }
      end
    end
  end

end