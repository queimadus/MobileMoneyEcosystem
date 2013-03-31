class ProductController < ApplicationController
  def add
     @p = Product.new(:name => params[:name], :image_url => params[:url],:price => params[:price],:reference => params[:reference],:brand => params[:brand])
     @p.merchant=current_user.merchant
     @p.save



#     respond_to do |format|
#       if  @p.save
 #        format.html { redirect_to "/home/index", notice:'Produto criado com sucesso!'}
 #      else
 #        format.html { redirect_to "/home/index", alert:'Não foi possivel criar o seu produto.' }
  #     end
 #    end

  end

  def listclientproducts
    @products = Product.find_by_client(current_user.id);
  end

  def edit

  end

  def discontinue
    p = Product.find(params[:id]);
    p.available = false;
    p.save;
  end


end
