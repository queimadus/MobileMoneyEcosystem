class ProductsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_is_merchant!
  include ApplicationHelper
  include ActionView::Helpers::TagHelper

  def new
    @product = Product.new

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
    @products = Kaminari.paginate_array(Product.find_all_by_merchant_id(current_user.merchant.id)).page(params[:page]).per(15)

    respond_to do |format|
        format.json { render :json => {:success => true, :html => render_to_string( :partial => 'product_list',
                                                                                    :locals => {:products => @products})}}
        format.html { render 'index.html.erb' }
    end

  end

  def edit

    @product = Product.find(params[:id])

    respond_to do |format|
      format.json { render :json => {:success => true, :html => render_to_string( :partial => 'edit',
                                                                                  :locals => {:product => @product})}}
      format.html { render '_edit.erb',:locals => {:product => @product} }  #TODO create another view to use this one --this is only for js disabled
    end
  end

  def update
    @product = Product.find(params[:product][:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        #format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :json => { :success => true,
                                        :updated => render_to_string( :partial => 'container',
                                                                      :locals => {:product => @product}),
                                        :html => "BOM",
                                        :id => @product.id,
                                        :notice => bootstrap_notice("Product was updated", :notice)
        }}
      else
       # format.html { render action: "edit" }
        format.json { render :json => { :success => false, :html => "MAU" }}
      end
    end
  end

  def discontinue
    p = Product.find(params[:id]);
    p.available = false;
    p.save;
  end


end
