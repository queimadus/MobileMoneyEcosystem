class HistoriesController < ApplicationController
  before_filter :authenticate_user!

  def index

    if current_user.is_client?
      client_history #params
    elsif  current_user.is_merchant?
      merchant_history #params
    else
      render :nothing => true
    end
  end

  protected

  def client_history

    search = params[:q]  ? params[:q]    : ""
    from = params[:from] ? params[:from] : Time.now.to_date-1.month
    to   = params[:to]   ? params[:to]   : Time.now.to_date


    @categories = category_query_parse(search)
    c = Cart.from_client(current_user.client).archived.between_dates(from,to).order("date(updated_at) desc")
    @carts = Kaminari.paginate_array(c).page(params[:page]).per(5)


    respond_to do |format|
        format.json { render :json => {:success => true, :html => render_to_string( :partial => 'client_history_list',
                                                                                    :locals => {:carts => @carts, :categories => @categories})}}
        format.html { render 'client_history' }
    end
  end

  def merchant_history
    search = params[:q]  ? params[:q]    : ""
    from = params[:from] ? params[:from] : Time.now.to_date-1.month
    to   = params[:to]   ? params[:to]   : Time.now.to_date


    @categories = category_query_parse(search)
    o = Order.from_merchant(current_user.merchant).between_dates(from,to).order("date(created_at) desc")


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


    respond_to do |format|
      format.json { render :json => {:success => true, :html => render_to_string( :partial => 'merchant_history_list',
                                                                                  :locals => {:orders => @orders, :categories => @categories})}}
      format.html { render 'merchant_history' }
    end
  end

  def category_query_parse(search)
    unless search.blank?
        result = []
        search.split(" ").each do |keyword|
          if(cat = Category.find_by_name(keyword))
            result << cat
          end
        end
        result
    end
  end

end
