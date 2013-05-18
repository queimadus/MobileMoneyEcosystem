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
    c = Cart.from(current_user.client).archived.between_dates(from,to)
    @carts = Kaminari.paginate_array(c).page(params[:page]).per(5)


    respond_to do |format|
        format.json { render :json => {:success => true, :html => render_to_string( :partial => 'client_history_list',
                                                                                    :locals => {:carts => @carts, :categories => @categories})}}
        format.html { render 'client_history' }
    end
  end

  def merchant_history

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
