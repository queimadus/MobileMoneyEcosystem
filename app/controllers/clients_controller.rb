class ClientsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_is_client!

  def update

    if params["client"]["name"]
      notice = "Name updated"
      failure = "Error"
      partial =  "settings/name_form"
    elsif params["client"]["credit"]
       i = params["client"]["credit"].to_i + current_user.client.credit
       params["client"]["credit"]=i
       notice = "Credited"
       failure = "Error"
       partial =  "credits/_credit_form"
    else
      notice = "Info updated"
      failure = "Error"
      partial =  "settings/client_extra_info_form"
    end

    current_user.client.update_attributes(params["client"])

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
