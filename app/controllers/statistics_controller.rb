class StatisticsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json
  include Statistic

  def index

    if current_user.is_client?
      if params[:kind]=="categories"
        client_statistics_categories
      elsif params[:kind]=="credit"
        client_statistics_credit
      else
        render "client_stats"
      end

    elsif  current_user.is_merchant?
      if params[:kind]=="categories"
        merchant_statistics_categories
      elsif params[:kind]=="credit"
        merchant_statistics_credit
      else
        render "merchant_stats"
      end
    else
      render :html => ""
    end
  end

  protected

  def merchant_statistics_categories
    from = params[:from] ? params[:from].to_date : 1.month.ago.to_date
    to   = params[:to]   ? params[:to].to_date   : Time.now.to_date
    render :json => merchant_category_prices_time(current_user.merchant.id,from,to)
  end

  def client_statistics_categories
    from = params[:from] ? params[:from].to_date : 1.month.ago.to_date
    to   = params[:to]   ? params[:to].to_date   : Time.now.to_date
    render :json => category_prices_time(current_user.client.id,from,to)
  end

  def client_statistics_credit
    from = params[:from] ? params[:from].to_date : 1.month.ago.to_date
    to   = params[:to]   ? params[:to].to_date   : Time.now.to_date
    render :json => credit_time(current_user.client.id,from,to)
  end

  def merchant_statistics_credit
    from = params[:from] ? params[:from].to_date : 1.month.ago.to_date
    to   = params[:to]   ? params[:to].to_date   : Time.now.to_date
    render :json => merchant_credit_time(current_user.merchant.id,from,to)
  end


end
