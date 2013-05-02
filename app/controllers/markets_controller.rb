class MarketsController < ApplicationController
  before_filter :find_merc

  def show
    @query = ""


    q = @merc.products.where(:available => true).order("products.id DESC")

    if params.has_key?(:q)  and !params{:q}.nil?  and !params[:q].blank?
      @query = params{:q}
      params[:q].split(" ").each do |keyword|
        if(Category.find_by_name(keyword))
          q=q.filter_by_categories(keyword)
        else
          q=q.where('products.name like ? OR products.brand like ?',"%"+keyword+"%", "%"+keyword+"%")
        end
      end
    end

    @products = Kaminari.paginate_array(q).page(params[:page]).per(16) if q
    @merchant_name = @merc.name
    @merchant_id = @merc.id

    respond_to do |format|
      format.json { render :json => {:success => true, :html => render_to_string( :partial => 'products',
                                                                                  :locals => {:products => @products})}}
        format.html { render html: "show.html.erb", :layout => false }

    end
  end

  protected
  def find_merc
    @merc = Merchant.find_by_name(params[:merchant_name])
    raise ActionController::RoutingError.new('Not Found') unless @merc
  end

end
