class CatsController < ApplicationController 

  def index
    #cats = Cat.all
    #render json: cats

    @cats = Cat.all
    render :index
  end

  def show
    # find_by() shows nill if a cat is not found
    # @cat = Cat.find_by(id: params[:id]) 

    # find() raises an exception error if a cat is not found
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end
  def create
    @cat = Cat.new(cat_params)

    if @cat.save
      # show user the cat show page
      redirect_to cat_url(@cat)
    else
      # show user the new cat form
      render :new
    end
  end

  def edit
    # gets id from params[:id] from the route edit_cat GET /cats/:id
    @cat = Cat.find_by(id: params[:id])
    render :edit
  end
  def update
    @cat = Cat.find_by(id: params[:id])

    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      render :edit
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:age, :birth_date, :color, :description, :name, :sex)
  end
end