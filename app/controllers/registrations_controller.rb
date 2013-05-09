# Class to override Devise's default path after sign up.
class RegistrationsController < Devise::RegistrationsController

  def new_merchant
    begin

      resource = build_resource({})
      respond_with resource

    rescue Error => e
      e.errors.each { |error| resource.errors.add :base, error }
      clean_up_passwords(resource)
      respond_with_navigational(resource) { render_with_scope :new_merchant }
    end
  end

  def selection
    render :selection
  end

  def create
    begin
      merch = params.has_key?(:merc) and params[:merc]=="1"
      User.transaction do

      u = build_resource
      if( merch )
        @c = Merchant.new(params[:merchant])
      else
        @c = Client.new(params[:client])
      end

      resource.valid?

      if @c.valid?
        if resource.valid?
          @c.user = u
          @c.save
          if resource.active_for_authentication?
            set_flash_message :notice, :signed_up if is_navigational_format?
            sign_up(resource_name, resource)
            respond_with resource, :location => after_sign_up_path_for(resource)
          else
            set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
            expire_session_data_after_sign_in!
            respond_with resource, :location => after_inactive_sign_up_path_for(resource)
          end
        else
          flash[:error] = "Please fill the form correctly"
          clean_up_passwords resource
          if merch
            render :action => "new_merchant"
          else
            render :action => "new"
          end
        end
      else
        flash[:error] = "Please fill the form correctly"
        clean_up_passwords resource

        if merch
          render :action => "new_merchant"
        else
          render :action => "new"
        end
      end
      end
    end

    rescue Error => e
      e.errors.each { |error| resource.errors.add :base, error }
      clean_up_passwords(resource)
      if merch
        render :action => "new_merchant"
      else
        render :action => "new"
      end
    end

  def after_update_path_for
    "/settings"
  end



  protected

  # Forces a user to be redirected to his own profile after signing up.
  def after_sign_up_path_for(resource)
    #"/users/"+current_user.id.to_s
    root_path
  end
end