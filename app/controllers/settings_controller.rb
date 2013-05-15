class SettingsController < ApplicationController
  before_filter :authenticate_user!

  def index

    if current_user.is_client?
     render 'client_view'
    elsif  current_user.is_merchant?
      render 'merchant_view'
    else
      render :nothing => true
    end
  end

  def update
    @setting = Setting.find(params[:id])

    respond_to do |format|
      if @setting.update_attributes(params[:setting])
        format.html { redirect_to @setting, notice: 'Setting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

end
