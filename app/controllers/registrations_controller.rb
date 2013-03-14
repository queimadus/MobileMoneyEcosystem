# Class to override Devise's default path after sign up.
class RegistrationsController < Devise::RegistrationsController

  def new_merchant
    begin

      resource = build_resource({})
      respond_with resource

    rescue Error => e
      e.errors.each { |error| resource.errors.add :base, error }
      clean_up_passwords(resource)
      respond_with_navigational(resource) { render_with_scope :new }
    end
  end



  def create
    begin

      super # this calls Devise::RegistrationsController#create

      if( params.has_key?(:merchant) )
         c = Merchant.new
      else
        c = Client.new
      end
      c.user = User.find_by_email(params[:user][:email])
      c.save

    rescue Error => e
      e.errors.each { |error| resource.errors.add :base, error }
      clean_up_passwords(resource)
      respond_with_navigational(resource) { render_with_scope :new }
    end
  end

  protected

  # Forces a user to be redirected to his own profile after signing up.
  def after_sign_up_path_for(resource)
    #"/users/"+current_user.id.to_s
    root_path
  end
end