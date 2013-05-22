class Api::ClientController < ApplicationController
  respond_to :json
  before_filter :authenticate_user!

  def info
    c = Client.find(current_user.client.id)
    if(c != nil)
      render :json=> {:success=>true,:credit =>c.credit ,:fname => current_user.client.first_name,:lname => current_user.client.last_name}
    else
      render :json=> {:success=>false }
    end
  end

end
