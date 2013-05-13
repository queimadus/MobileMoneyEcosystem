class MerchantsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_is_merchant!

  def update

    current_user.merchant.update_attributes(params["merchant"])

    respond_to do |format|
      if current_user.merchant.save
        format.json { render json: {:success => true,
                                    :html => render_to_string( :partial => 'settings/bank_account_form',
                                                               :locals => {:resource => current_user.merchant}),
                                    :notice => "Bank account updated"}}

        format.html { redirect_to settings_path, notice: "Bank account updated" }
      else
        format.json { render json: {:success => false,
                                    :html => render_to_string( :partial => 'settings/bank_account_form',
                                                               :locals => {:resource => current_user.merchant}),
                                    :notice => "Bank account not updated"}}

        format.html { redirect_to settings_path, error: "Bank account not updated" }
      end
    end
  end

end
