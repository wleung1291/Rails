class UsersController < ApplicationController

  # index action
  def index
    # search functionality so users can search for other users by name
    # localhost:3000/users?query=rob
    if params[:query]
      render json: User.where("username LIKE ?", "%#{params[:query]}%")
    else
      render json: User.all
    end
  end
  
  # create action
  def create
    user = User.new(user_params)

    if user.save
      render json: user
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end
  
  # show action
  def show
    user = User.find(params[:id])
    render json: user
  end
  
  # update action, use ActiveRecord::Base#update_attributes. Updates all the 
  # attributes from the passed-in Hash and saves the record. 
  # If the object is invalid, the saving will fail and false will be returned.
  def update
    user = User.find(params[:id])

    # Use update with user_params to do a mass-assignment update and save. 
    if user.update_attributes(user_params)
      render json: user
    else 
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end
  
  # destroy action
  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: user
  end

  private

  # ActionController::Base#params
  # The #permit method of the hash-like object returned by #params "whitelists"
  # the title and body attributes, allowing them to be mass-assigned. All 
  # othernon-whitelisted attributes will be ignored.
  def user_params
    params.require(:user).permit(:username)
    
    #params.require(:user).permit(:name, :email)
    # Parameters: {"user"=>{"name"=>"asd", "email"=>"asdas@gmail.com"}}
    # puts "HELLO #{params.require(:user).permit(:name, :email)}"
    #   >> HELLO {"name"=>"asd", "email"=>"asdas@gmail.com"}
  end
end