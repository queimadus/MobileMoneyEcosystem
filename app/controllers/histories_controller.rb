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

    from = params[:from] ? params[:from] : Time.now.to_date-1.month
    to   = params[:to]   ? params[:to]   : Time.now.to_date

    @carts = Cart.from(current_user.client).archived.between_dates(from,to)

    respond_to do |format|
        format.html { render 'client_history' }
        format.json { render json: { :ok => "ok"} }
    end
  end

  def merchant_history

  end

end
