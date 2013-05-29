class Api::LimitsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def show
    return invalid_params unless params.has_key?(:id)

    limit = Limit.from_client(current_user.client).where(:id => params[:id]).first
    if limit.nil?
      render :json => {:success => false}
    else
      render :json => {:success => true, :limit => limit}
    end
  end

  def all
    limits = Limit.from_client(current_user.client)
    if limits.nil?
      render :json => {:success => false}
    else
      render :json => {:success => true, :limits => limits}
    end
  end

  def modify
    return invalid_params unless params.has_key?(:id)

    edits = {}
    if params.has_key?(:max)
      edits[:max] = params[:max]
    end
    if params.has_key?(:period)
      edits[:period] = params[:period]
    end

    limit = Limit.from_client(current_user.client).where(:id => params[:id]).first
    if !limit.nil? and limit.update_attributes(edits)
      render :json => {:success => true, :limit => limit}
    else
      render :json => {:success => false}
    end
  end
end
