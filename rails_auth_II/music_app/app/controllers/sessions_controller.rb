class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    email = params[:user][:email]
    pw = params[:user][:password]
    @user = User.find_by_credentials(email, pw)

    if @user.nil?
      flash[:errors] = ["Invalid email and/or password"]
      redirect_to new_session_url
    else
      login!(@user)
      redirect_to bands_url
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end



end