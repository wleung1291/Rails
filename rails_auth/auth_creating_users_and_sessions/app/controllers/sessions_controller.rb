class SessionsController < ApplicationController

  # POSTing to /session (to the SessionsController#create action) will sign the 
  # user in
  def create
    # in models/user.rb
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user.nil?
      #render json: 'Credentials were wrong'
      redirect_to new_session_url
    else
      # sign the user in
      login!(@user) # in ApplicationController
      redirect_to user_url(@user)
    end
  end

  def new
    # if a user is logged in, cannot login another user at the same time
    if current_user.nil?
      # login form
      render :new
    else
      # will redirec to user's show page
      redirect_to user_url
    end
  end    

  def destroy
    # log out
    logout! # in ApplicationController
    redirect_to new_session_url # localhost:3000/session/new
  end 
end