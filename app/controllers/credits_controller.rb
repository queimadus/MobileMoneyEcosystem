class CreditsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_is_client!

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

    else

    end
    render 'new'
  end


end
