class ProductsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_is_merchant!
  include ApplicationHelper
  include ActionView::Helpers::TagHelper

  def new
    @product = Product.new

    respond_to do |format|
      format.json { render :json => {:success => true, :html => render_to_string( :partial => 'new',
                                                                                  :locals => {:product => @product})}}
      format.html { render '_new.erb',:locals => {:product => @product} }  #TODO create another view to use this one --this is only for js disabled
    end
  end


  def create
     #@p = Product.new(:name => params[:name], :image_url => params[:url],:price => params[:price],:reference => params[:reference],:brand => params[:brand])
     @p = Product.new(params[:product])
     @p.merchant=current_user.merchant
     @p.categories << Category.find(params[:category][:id])
     @p.set_hash
     @p.available = true
     #generate qrcode
     #add support for uploaded images

     respond_to do |format|
       if @p.save
         q = Product.where(:products => {:merchant_id => current_user.merchant.id}, :available => true ).order("products.id DESC")
         @products = Kaminari.paginate_array(q).page(params[:page]).per(15)
         format.json { render :json => {:success => true, :notice => bootstrap_notice("Product was successfully created", :notice),
                                                          :html => render_to_string( :partial => 'product_list',
                                                                                     :locals => {:products => @products})}}
         format.html { redirect_to products_path, notice: 'Product was successfully created' }

       else

         format.json { render :json => { :success => false,
                                         :html => render_to_string( :partial => 'form',
                                                                    :locals => {:product => @p, :submit_name => "Create"}),
                                         :notice => bootstrap_notice("Product was not created", :error)
         }}
         format.html { redirect_to products_path, alert: 'Product was not successfully created' }
       end
     end
  end

  def index

    #if params[q]? => is q a category? -> filter_by category else filter_by name or


    @query = ""
    q = Product.where(:products => {:merchant_id => current_user.merchant.id}, :available => true ).order("products.id DESC")
    if params.has_key?(:q)  and !params{:q}.nil?  and !params[:q].blank?
      @query = params{:q}
      params[:q].split(" ").each do |keyword|
        if(Category.find_by_name(keyword))
          q=q.filter_by_categories(keyword)
        else
          q=q.where('products.name like ? OR products.brand like ?',"%"+keyword, "%"+keyword)
        end
      end
    end

    @products = Kaminari.paginate_array(q).page(params[:page]).per(15)


    #Company.includes(:branches).where(:branches => {:id => 3})

    respond_to do |format|
        format.json { render :json => {:success => true, :html => render_to_string( :partial => 'product_list',
                                                                                    :locals => {:products => @products})}}
        format.html { render 'index.html.erb' }
    end

  end

  def edit

    @product = Product.find(params[:id])
    head :forbidden unless @product.merchant_id==current_user.merchant.id

    respond_to do |format|

      format.json { render :json => {:success => true, :html => render_to_string( :partial => 'edit',
                                                                                  :locals => {:product => @product})}}
      format.html { render '_edit.erb',:locals => {:product => @product} }  #TODO create another view to use this one --this is only for js disabled

    end
  end

  def update
    @product = Product.find(params[:product][:id])

    respond_to do |format|
      if @product.update_attributes(params[:product]) and @product.merchant_id==current_user.merchant.id

        format.json { render :json => { :success => true,
                                        :updated => render_to_string( :partial => 'container',
                                                                      :locals => {:product => @product}),
                                        :html => render_to_string( :partial => 'edit',
                                                                   :locals => {:product => @product}),
                                        :id => @product.id,
                                        :notice => bootstrap_notice("Product was updated", :notice)
        }}
        format.html { redirect_to products_path, notice: 'Product was successfully updated' }
      else

        format.json { render :json => { :success => false,
                                        :html => render_to_string( :partial => 'edit',
                                                                   :locals => {:product => @product}),
                                        :id => @product.id,
                                        :notice => bootstrap_notice("Product was not updated", :error)
        }}
        format.html { redirect_to products_path, alert: 'Product was not successfully updated' }
      end
    end
  end

  def destroy
    p = Product.find(params[:id])
    p.available = false


    respond_to do |format|
      if p.save
        format.json { render :json => {:success => true,
                                       :notice => bootstrap_notice("Product was removed", :notice),
                                       :html => render_to_string( :partial => 'product_list',
                                                                  :locals => {:products => Kaminari.paginate_array(Product.where(:products => {:merchant_id => current_user.merchant.id}, :available => true ).order("products.id DESC")).page(params[:page]).per(15)})}}

        format.html { redirect_to products_path, notice: "Product was removed" }
      else
        format.html { redirect_to products_path, error: "Product was not removed" }
      end
    end



  end

end
