class Api::ClientController < ApplicationController
  respond_to :json
  before_filter :authenticate_user!

  def info
      render :json=> {:success=>true,:credit =>current_user.client.credit ,:name => current_user.client.first_name+" "+current_user.client.last_name}
  end

end
