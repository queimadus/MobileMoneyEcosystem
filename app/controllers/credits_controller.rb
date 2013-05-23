class CreditsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_is_client!
  include ApplicationHelper
  include ActionView::Helpers::TagHelper
  require "rubygems"
  require "braintree"

  Braintree::Configuration.environment = :sandbox
  Braintree::Configuration.merchant_id = "m3spqbmq9kbmymwg"
  Braintree::Configuration.public_key = "jbv6s4yfkdsdj3vd"
  Braintree::Configuration.private_key = "953f2ec66b8afa868a2081b71497adf6"

  def index
    render 'new'
  end

  def update

    @result = Braintree::Transaction.sale(
        :amount => params[:amount],
        :credit_card => {
            :number => params[:number],
            :cvv => params[:cvv],
            :expiration_month => params[:month],
            :expiration_year => params[:year]
        },
        :options => {
            :submit_for_settlement => true
        }
    )



    if @result.success?
       current_user.client.credit += params[:amount].to_f
       current_user.client.save
       valid=true
    else
       valid=false
    end


    respond_to do |format|
      if valid
        format.json { render :json => {:success => true,
                                       :notice => bootstrap_notice("Success", :notice),
                                       :html => render_to_string( :partial => 'credit_form',
                                                                  :locals => {:result => @result})}}
        format.html { render 'new', :notice => "Success"}
      else
        format.json { render :json => {:success => false,
                                       :notice => bootstrap_notice("Error", :error),
                                       :html => render_to_string( :partial => 'credit_form',
                                                                  :locals => {:result => @result})}}
        format.html { render 'new', :error => "Error"}
      end
    end
  end


end
