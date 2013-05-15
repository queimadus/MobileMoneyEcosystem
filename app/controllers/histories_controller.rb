class HistoriesController < ApplicationController
  before_filter :authenticate_user!

  def index

    if current_user.is_client?
      client_history #params
    elsif  current_user.is_merchant?
      merchant_history #params
    else
      render :nothing => true
    end
  end

  protected

  def client_history

    respond_to do |format|
        format.html { render 'client_history' }
        format.json { render json: { :ok => "ok"} }
    end
  end

  def merchant_history

  end

end
