class CatsController < ApplicationController
  # Allow unlogged in users to browse cats.
  # Only logged in users can use new, create, edit, update
  before_action :require_current_user!, only: [:new, :create, :edit, :update]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    #@cat = Cat.new(cat_params)
    
    # @cat.user_id = current_user.id # Makes sure the cat has an owner
    
    # In this case, the form submitter must be logged in or they couldn't view 
    # the form to begin with, so we can set cat.owner to the current_user
    @cat = current_user.cats.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    #@cat = Cat.find(params[:id])

    # searches for the cat among only the current_user's cats with the 
    # User#cats association.
    @cat = current_user.cats.find(params[:id])

    render :edit

  end
  
  def update
    #@cat = Cat.find(params[:id])

    # searches for the cat among only the current_user's cats with the 
    # User#cats association.
    @cat = current_user.cats.find(params[:id])

    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:age, :birth_date, :color, :description, :name, :sex)
  end
end
