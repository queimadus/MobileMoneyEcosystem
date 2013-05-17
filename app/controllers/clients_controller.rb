class ClientsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_is_client!

  def update
    current_user.client.update_attributes(params["client"])

    if params["client"]["first_name"] or params["client"]["last_name"]
      notice = "Name updated"
      failure = "Error"
      partial =  "settings/name_form"
    else
      notice = "Info updated"
      failure = "Error"
      partial =  "settings/client_extra_info_form"
    end


    respond_to do |format|
      if current_user.client.save
        format.json { render json: {:success => true,
                                    :html => render_to_string( :partial => partial,
                                                               :locals => {:resource => current_user.client}),
                                    :notice => notice}}

        format.html { redirect_to settings_path, notice: notice }
      else
        format.json { render json: {:success => false,
                                    :html => render_to_string( :partial => partial,
                                                               :locals => {:resource => current_user.client}),
                                    :notice => failure}}

        format.html { redirect_to settings_path, error: failure }
      end
    end
  end

end
