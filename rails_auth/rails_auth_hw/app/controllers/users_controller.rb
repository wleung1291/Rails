class UsersController < ApplicationController 
  before_action :require_current_user!, except: [:create, :new]

  def new
    @user = User.new
    render :new
  end
  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user)
      redirect_to users_url
    else
      render :new
    end
  end

  def show
    # show the user's details (just their username)
    if current_user.nil?
      # let them log in
      redirect_to new_session_url
      return
    end

    @user = current_user
    render :show
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end