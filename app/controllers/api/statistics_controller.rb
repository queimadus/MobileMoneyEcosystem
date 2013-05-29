class Api::StatisticsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json
  include Statistic


  def index
    return invalid_params unless params.has_key?(:period)

    if params[:period]=="week"
      from = 1.week.ago.to_date
    elsif  params[:period]=="month"
      from = 1.month.ago.to_date
    else
      return invalid_params
    end

    to = Time.now.to_date

    reply = {
      :pie => category_prices_time(current_user.client.id, from,to),
      :bar => credit_time(current_user.client.id, from,to)
    }

    if reply.nil?
      render :json => {:success => false}
    else
      render :json => {:success => true, :data => reply}
    end
  end

end
