class Api::CartController < ApplicationController

  respond_to :json
  before_filter :authenticate_user!

  def add_product

    return invalid_params unless params.has_key?(:id) and params.has_key?(:quantity)

    product = Product.find(params[:id])
    force = params[:force] || false

    if !force and  product.will_break_limit current_user.client, params[:quantity].to_i
      render :json => {:success => false, :code=> 1, :message => "Will break limit"}
      return
    else
      if !force and  product.will_break_cart current_user.client
        render :json => {:success => false, :code=> 2, :message => "Will break cart"}
        return
      else
        if product.add_to_cart current_user.client, params[:quantity].to_i
          render :json => {:success => true, :cart => Cart.active.from_client(current_user.client)}
          return
        else
          render :json => {:success => false, :code=> 3, :message => "Already in cart"}
          return
        end
      end
    end
 end

 def show
   if(params.has_key?(:id))
     cart = Cart.archived.from_client(current_user.client).where(:id => params[:id]).first
     if cart and cart.items.size > 0
       render :json =>  {:success => true, :cart => cart}
     else
       render :json => {:success => false}
     end
   else
     cart = Cart.active.from_client(current_user.client).first
     if cart and cart.items.size > 0
      render :json => {:success => true, :cart => cart}
     else
       render :json => {:success => false}
     end
   end
 end

 def remove_product
   return invalid_params unless params.has_key?(:id)

   product = Product.find(params[:id])
   if product.remove_from_cart current_user.client
      render :json => {:success => true}
   else
     render :json => {:success => false}
   end
 end

  def modify_quantity
    return invalid_params unless params.has_key?(:id) and params.has_key?(:quantity)

    product = Product.find(params[:id])

    if product.edit_quantity current_user.client, params[:quantity]
      render :json => {:success => true}
    else
      render :json => {:success => false}
    end
  end

  def history
    #return invalid_params unless params.has_key?(:id)

    #page = params[:page] || 1

    carts = Cart.archived.from_client(current_user.client)
    #cart_slice = Kaminari.paginate_array(carts).page(page).per(20)

    if cart_slice.size>0
      render :json => {:success => true,:carts => carts}
    else
      render :json => {:success => false}
    end
  end

  def clear_cart
    success = Cart.clear_from_client current_user.client
    render :json=> {:success=>success}
  end

  def buy
    force = params[:force] || false

    cart = Cart.active.from_client(current_user.client).first

    if cart and  cart.items.size > 0

      cats = Limit.breaks_on_buy_from_client current_user.client
      if !cats.empty? and !force
          cats_j = []
          cats.each do |c|
            cats_j << {:name => c}
          end
          render :json => {:success => false, :code => 1, :categories => cats_j, :message => "Will break limit" }
      end

      if Cart.buy_from_client current_user.client
        render :json=> {:success=>true}
      else
        render :json => {:success=>false, :code => 2, :message => "Insufficient credit"}
      end

    else

      render :json => {:success=>false, :code => 3, :message => "No cart"}

    end
  end



=begin
  #complete
  def listcart

    c = Cart.active.from_client(current_user.client).first
    if c == nil
      result = {:success=>false}
    else
      result = {:success=>true}
      result.merge(:content=>[])
      res = []
      qt = {}
      cartitems = []
      c.items.each do |item|
        if(qt[item.product_id] != nil)
          qt[item.product_id] = qt[item.product_id] + item.quantity
        else
          qt[item.product_id] = item.quantity
          cartitems << item
        end
      end
      cartitems.each do |i|
        new= []
        p = Product.find(i.product_id)
        m = Merchant.find(p.merchant_id)
        new  = {:product_id => i.product_id,:actual_price => i.actual_price,
                :quantity => qt[i.product_id], :name => p.name,:image_url => p.image_url,
                :category => Category.find(i.category_id).name,
                :merchant => m.name}
        #juntar item quantity do mesmo merch
        res << new
      end
      result[:content] = res

    end
      render :json=> result
  end
=end
end
