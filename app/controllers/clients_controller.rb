class ClientsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_is_client!

  def update

    if params["client"]["first_name"] or params["client"]["last_name"]
      notice = "Name updated"
      failure = "Error"
      partial =  "settings/name_form"
    elsif params["client"]["credit"]

      Braintree::Configuration.environment = :sandbox
      Braintree::Configuration.merchant_id = "m3spqbmq9kbmymwg"
      Braintree::Configuration.public_key = "jbv6s4yfkdsdj3vd"
      Braintree::Configuration.private_key = "953f2ec66b8afa868a2081b71497adf6"


        result = Braintree::Transaction.sale(
            :amount => params[:amount],
            :credit_card => {
                :number => params[:number],
                :cvv => params[:cvv],
                :expiration_month => params[:month],
                :expiration_year => params[:year]
            },
            :options => {
                :submit_for_settlement => true
            }
        )

       result

       i = params["client"]["credit"].to_f + current_user.client.credit
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
