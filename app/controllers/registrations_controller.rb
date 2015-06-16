class RegistrationsController < Devise::RegistrationsController

	def create
		@user = User.new(sign_up_params)
		if @user.save
			flash[:success] = "Signed up successfully!"
			redirect_to root_path
		else
			flash[:danger] = "Uh oh! Something went wrong!"
			render 'new'
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
