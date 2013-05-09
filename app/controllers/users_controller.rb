class UsersController < ApplicationController

  def update

    @user = User.find(current_user.id)

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.json { render :json => {:success => true }}

        format.html { redirect_to products_path, notice: "Product was removed" }
      end
    end
  end

end