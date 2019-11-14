class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    username = params[:user][:username]
    password = params[:user][:password]
    @user = User.find_by_credentials(username, password)

    if @user.nil?
      flash[:errors] = ["Invalid email and/or password"]
      redirect_to new_session_url
    else
      login!(@user)
      redirect_to subs_url
    end
  end
  
  def destroy
    logout!
    redirect_to new_session_url
  end

end