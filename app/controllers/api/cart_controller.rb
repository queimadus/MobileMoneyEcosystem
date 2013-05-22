class Api::CartController < ApplicationController

  respond_to :json
  before_filter :authenticate_user!

  def create
      c = Cart.new
      c.client=current_user.client
      if c.save
        render :json=> {:success=>true,:cart_id =>c.id}
      else
        render :json=> {:success=>false }
      end
  end

  def addproduct
    c = Cart.active.from(current_user.client).first
    i = Item.new
    i.cart = c
    p = Product.find_by_qrcode(params[:qrcode])
    i.product = p
    i.actual_price = p.price
    if(current_user.client.credit < p.price)
      render :json=> {:success=>false, :message => "Not enough credit"}
    end
    i.quantity = params[:quantity]
    if i.save
      render :json=> {:success=>true}
    else
      render :json=> {:success=>false}
    end
  end

  def listcart

    c = Cart.active.from(current_user.client).first
    #  products = []
    yeah = current_user.client.id
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
                :merchant_name => m.name}
        #juntar item quantity do mesmo merch
        res << new
      end
      result[:content] = res

    end
    render :json=> result
  end

  def show
    c = Cart.find(params[:id])
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
                :merchant_name => m.name}
        #juntar item quantity do mesmo merch
        res << new
      end
      result[:content] = res

    end
    render :json=> result


  end

  def removeproduct

    i = Item.where(:product_id => params[:product_id],
                   :cart_id => Cart.active.from(current_user.client)).first
    if Item.destroy(i.id)
      render :json=> {:success=>true}
    else
      render :json=> {:success=>false}
    end

  end

  def completed
    c = Cart.active.from(current_user.client).first
    c.items.each do |item|
      p = Product.find(item.product_id)
      if(!Order.where(:merchant_id => p.merchant_id,:sent => false))
        o = Order.new
        o.merchant = p.merchant
        o.save
      else
        o = Order.where(:merchant_id => p.merchant_id,:sent => false).first
      end
      item.order = o
    end
    c.complete = true
    if c.save
      render :json=> {:success=>true}
    else
      render :json=> {:success=>false}
    end
  end

  def clearcart
    c = Cart.active.from(current_user.client).first
    if c == nil
      render :json=> {:success=>false}
    else
      c.items.each do |item|
        Item.destroy(item.id)
      end
      render :json=> {:success=>true}
    end
  end

  def allcarts
    #c = Cart.where("created_at >= :start_date AND created_at <= :end_date", {:start_date => params[:start_date], :end_date => params[:end_date]})
    c = Cart.from(current_user.client).between_dates(params[:start_date],params[:end_date])
    if c == nil
      result = {:success=>false}
    else
      result = {:success=>true}
      result.merge(:content=>[])
      carts = []
        c.each do |cart|
        cartprice = 0
        cart.items.each do |i|
          cartprice = cartprice + i.actual_price
        end
        carts << {:date => cart.created_at,
                 :pricesum => cartprice
        }
      end
      result[:content] = carts
    end
    render :json=> result
  end

end
