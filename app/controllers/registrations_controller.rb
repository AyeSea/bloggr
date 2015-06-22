class RegistrationsController < Devise::RegistrationsController

  before_filter :store_location

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    return unless request.get? 
    if (request.path != "/users/sign_in" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/password/new" &&
        request.path != "/users/password/edit" &&
        request.path != "/users/confirmation" &&
        request.path != "/users/sign_out" &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath 
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url]
  end

  def after_sign_out_path_for(resource)
    root_path
  end

 def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        #Signin user after succesful signup.
        sign_in(resource_name, resource)
        #Redirect user to their profile (show) page.
        respond_with resource, location: user_path(current_user)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

	private

		def sign_up_params
			params.require(:user).permit(:first_name, :last_name, :email, :email_confirmation, :gender, :password, 
				                           :password_confirmation, :birthday)
		end

		def account_update_params
			params.require(:user).permit(:first_name, :last_name, :email, :email_confirmatin, :gender, :password, 
				                           :password_confirmation, :current_password, :birthday)
		end

end
