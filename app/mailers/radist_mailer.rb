class RadistMailer < ApplicationMailer
  default from: 'from@example.com'
 
  def welcome_email(user)
 #    users = User.where(radist: true)
	# users.each do |user|
		@user = user
	    @url  = 'http://example.com/login'
	    mail(to: @user.email, subject: 'Радист сайта "Царь Горы"')
	# end
  end
end
