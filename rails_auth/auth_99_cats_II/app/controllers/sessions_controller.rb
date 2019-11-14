class SessionsController < ApplicationController
  # while a user is signed in, can't sign in(new/create), can only logout
 before_action :require_no_user!, only: [:create, :new]
  
  def new
    render :new  # login form
  end
  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user.nil?
      flash[:errors] = ["Incorrect username and/or password"]
      redirect_to new_session_url
    else
      login!(@user)
      redirect_to cats_url
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
end