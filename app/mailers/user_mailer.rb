class UserMailer < ApplicationMailer
	if Rails.env.development? || Rails.env.test?
		default from: 'notifications@example.com'
	else
		default from: ENV['SENDGRID_USERNAME']
	end

	def welcome_email(user)
		@user = user
		email_with_name = %("#{@user.full_name}" <#{@user.email}>)
		@login_url = 'https://lit-waters-7717.herokuapp.com/users/sign_in'
		@facebook_login_url = 'http://on.fb.me/1GVwrl2'
		mail(to: email_with_name, subject: 'Welcome to Clonebook!')
	end
end
