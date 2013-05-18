class Api::ClientInfoController < ApplicationController
  respond_to :json
  before_filter :authenticate_user!

  def credit
    c = Client.find(current_user.client.id).first
    if(c != nil)
      render :json=> {:success=>true,:credit =>c.credit}
    else
      render :json=> {:success=>false }
    end
  end

end
