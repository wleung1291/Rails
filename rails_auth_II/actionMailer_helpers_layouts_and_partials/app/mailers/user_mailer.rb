class UserMailer < ApplicationMailer
  default from: "App Academy <contact@appacademy.io>"

  def welcome_email(user)
    @user = user
    @url  = 'http://localhost:3000/session/new'
    #mail(to: @user.email, subject: 'Welcome to My Awesome Site')
    mail(to: @user.username, subject: 'Welcome to My Awesome Site')
  end
end
