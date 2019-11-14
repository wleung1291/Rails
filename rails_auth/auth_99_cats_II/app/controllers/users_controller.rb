class UsersController < ApplicationController
  # before running new/create methods, call require_no_user! from applicationCon
  # Does not let a signed in user create a new user while signed in 
  before_action :require_no_user!
  
  def new
    @user = User.new
    render :new
  end
  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  
  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end