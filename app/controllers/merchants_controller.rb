class MerchantsController < ApplicationController

  # GET /merchants/1
  # GET /merchants/1.json
  def show
    q = Merchant.find_by_name(params[:merchant_name])
    @products = Kaminari.paginate_array(q.products).page(params[:page]).per(16) if q

    respond_to do |format|
      if q
        format.json { render partial: "products", products: @products }
        format.html { render html: "show.html.erb", :layout => false }
      else
        format.html { render html: "derp", :layout => false}
      end

    end
  end

end
