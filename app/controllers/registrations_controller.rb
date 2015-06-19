class RegistrationsController < Devise::RegistrationsController

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
        respond_with resource, location: after_sign_up_path_for(resource)
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

	protected

		def after_sign_up_path_for(resource)
			after_sign_in_path_for(resource)
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
