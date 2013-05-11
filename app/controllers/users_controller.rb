class UsersController < ApplicationController

  def update

    @user = User.find(current_user.id)

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.json { render json: {:success => true,
                                    :html => render_to_string( :partial => 'settings/avatar_form',
                                                               :locals => {:resource => @user}),
                                    :notice => "Avatar updated"}}

        format.html { redirect_to settings_path, notice: "Avatar updated" }
      else
        format.json { render json: {:success => false,
                                    :html => render_to_string( :partial => 'settings/avatar_form',
                                                               :locals => {:resource => @user}),
                                    :notice => "Avatar not updated"}}

        format.html { redirect_to settings_path, error: "Avatar not updated" }
      end
    end
  end

end