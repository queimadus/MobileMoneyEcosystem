class CreditsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_is_client!

  def index
    render 'new'
  end

  def update
    @client = current_user.client
    @client.credit += params[:client][:credit];
    @client.save
  end


end
