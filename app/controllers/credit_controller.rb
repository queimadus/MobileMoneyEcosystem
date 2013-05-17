class CreditController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_is_client!
  include ApplicationHelper
  include ActionView::Helpers::TagHelper

  # PUT /credit/1
  # PUT /credit/1.json
  def update
    @client = current_user.client


    @client.credit += params[:client][:credit];
    @client.save

 # if params[:credit].is_a?
   # @client.credit =  @credit + params[:credit].reject(&:blank?) unless params[:credit].nil?
    #@client.save

  #else



  end
    #end

end
