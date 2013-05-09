class MerchantsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_is_merchant!

  def update

    current_user.merchant.update_attributes(params["merchant"])

    respond_to do |format|
      if current_user.merchant.save
        format.json { render :json => {:success => true, :notice => bootstrap_notice("Saved", :notice) }}
        format.html { redirect_to settings_path }
      else
        format.json { render :json => {:success => false, :notice => bootstrap_notice("Failure", :notice) }}
        format.html { redirect_to settings_path }
      end
    end
  end

end
