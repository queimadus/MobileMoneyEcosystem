class HomeController < ApplicationController
  #before_filter :authenticate_user!
  respond_to :html

  def index
    if current_user
      if current_user.is_client?
        client_history #params
      else  current_user.is_merchant?
        merchant_history #params
      end
    else
      render "global"
    end
  end

  protected

  def client_history

    @current_cart = Cart.from_client(current_user.client).active.first
    @last_cart = Cart.from_client(current_user.client).archived.order("date(updated_at) desc").first
    @a = "client"

    render "client_home"
  end

  def merchant_history
=begin
    search = params[:q]  ? params[:q]    : ""
    from = params[:from] ? params[:from] : Time.now.to_date-1.month
    to   = params[:to]   ? params[:to]   : Time.now.to_date


    @categories = category_query_parse(search)
    o = Order.from(current_user.merchant).between_dates(from,to).order("date(created_at) desc")

    arr = []
    temp = []
    o.each do |e|
      if temp.empty? or temp.last.created_at.to_date==e.created_at.to_date
        temp << e
      else
        temp2=[]
        temp.each do |t|
          temp2<<t.id
        end
        arr << temp2
        temp = []
      end
    end
    unless temp.empty?
      arr << temp
    end

    @orders = Kaminari.paginate_array(arr).page(params[:page]).per(5)
=end

    render "merchant_home"
  end

end
