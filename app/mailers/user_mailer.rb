class UserMailer < ActionMailer::Base
	default from: "noreply@spartaroomie.com"

	def registration_confirmation(user)
		@user = user
		@name = @user.firstName << " " << @user.lastName
		mail(:to =>  "#{@name} <#{user.email}>", :from => "SpartaRoomie <spartaroomie@gmail.com>", :subject => "SpartaRoomie Account Email Confirmation")
	end
end