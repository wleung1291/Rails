class UsersController < ApplicationController
  # before actions are called require current user to be logged in except for 
  # create and new actions; those are needed before a user is signed up
  before_action :require_current_user!, except: [:create, :new]

  def new
    # if a user is logged in, cannot create a new user at the same time
    if current_user.nil?
      @user = User.new
      render :new
    else
      # will redirect to the current users show page
      redirect_to user_url
    end
  end
  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      render json: @user.errors.full_messages
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
    # Notice that we are calling #permit with :password, and not with 
    # password_digest. Is this ok? Yes: Just like in your Active Record Lite 
    # project, mass-assignment will call the setter method password=. It is 
    # totally okay that this doesn't set a password column.
    params.require(:user).permit(:username, :password)
  end
end