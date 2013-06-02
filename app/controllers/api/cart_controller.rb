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

    unless carts.nil?
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
end
