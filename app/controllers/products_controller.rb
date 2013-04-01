class ProductsController < ApplicationController

  def new
    Product.new
    render :action => "new"
  end

  def create
     #@p = Product.new(:name => params[:name], :image_url => params[:url],:price => params[:price],:reference => params[:reference],:brand => params[:brand])
     @p = Product.new(params[:product])
     @p.merchant=current_user.merchant
     #generate qrcode
     #add support for uploaded images
     @p.save
  end

  def index
    @products = Kaminari.paginate_array(Product.find_all_by_merchant_id(current_user.merchant.id)).page(params[:page]).per(18)


  end

  def edit

  end

  def discontinue
    p = Product.find(params[:id]);
    p.available = false;
    p.save;
  end


end
