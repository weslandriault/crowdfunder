class UserMailer < ApplicationMailer
	default from: 'notifications@example.com'

	def welcome_email(user)
		@user = user
		@url = 'http://example.com/Login'
		mail(to: @user.email, subject: 'Welcome to crowdfunder son')
	end
end
