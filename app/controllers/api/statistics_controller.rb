class Api::LimitsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json
  require "statistic"

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
      :pie => Statistic.client_statistics_categories(current_user.client.id, from,to),
      :bar =>Statistic.client_statistics_credit(current_user.client.id, from,to)
    }

    if reply.nil?
      render :json => {:success => false}
    else
      render :json => {:success => true, :data => reply}
    end
  end

end
