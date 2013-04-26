class MerchantsController < ApplicationController

  # GET /merchants/1
  # GET /merchants/1.json
  def show

    @query = ""

    merc = Merchant.find_by_name(params[:merchant_name])
    q = merc.products.where(:available => true).order("products.id DESC")

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
    @merchant_name = merc.name

    respond_to do |format|
      if merc
        format.json { render partial: "products", products: @products }
        format.html { render html: "show.html.erb", :layout => false }
      else
        format.html { render html: "derp", :layout => false}
      end

    end
  end

end
