class Api::ProductsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json


  def show
    p = Product.find(params[:id])
    if p == nil
      result = {:success => false}
    else
      m = p.merchant
      result = {:success => true, :content => {
          :id => p.id,
          :name => p.name,
          :brand => p.brand,
          :company => m.name,
          :price => p.price,
          :image_url => p.image_url
      }}
    end
    render :json=> result
  end

  def scan
    p = Product.where(:qrcode => params[:qrcode])
    if p == nil
      result = {:success => false}
    else
      m = p.merchant
      result = {:success => true, :content => {
          :id => p.id,
          :name => p.name,
          :brand => p.brand,
          :company => m.name,
          :price => p.price,
          :image_url => p.image_url
      }}
    end
    render :json=> result
  end

end


