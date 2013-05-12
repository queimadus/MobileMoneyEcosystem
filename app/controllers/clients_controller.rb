class ClientsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_is_client!

  def update
    current_user.client.update_attributes(params["client"])

    respond_to do |format|
      if current_user.client.save
        format.json { render json: {:success => true,
                                    :html => render_to_string( :partial => 'settings/name_form',
                                                               :locals => {:resource => current_user.client}),
                                    :notice => "Name updated"}}

        format.html { redirect_to settings_path, notice: "Name updated" }
      else
        format.json { render json: {:success => false,
                                    :html => render_to_string( :partial => 'settings/name_form',
                                                               :locals => {:resource => current_user.client}),
                                    :notice => "Name not updated"}}

        format.html { redirect_to settings_path, error: "Name not updated" }
      end
    end
  end

end
