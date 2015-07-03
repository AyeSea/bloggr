class UserMailer < ApplicationMailer
	default from: 'notifications@example.com'

	def welcome_email(user)
		@user = user
		email_with_name = %("#{@user.full_name}" <#{@user.email}>)
		@login_url = 'https://lit-waters-7717.herokuapp.com/users/sign_in'
		@facebook_login_url = 'http://on.fb.me/1GVwrl2'
		mail(to: email_with_name, subject: 'Welcome to Clonebook!')
	end
end
