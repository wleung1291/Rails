class CatRentalRequestsController < ApplicationController
  def index
    @cat_rental_request = CatRentalRequest.all
    render :index
  end

  def new
    @cat_rental_request = CatRentalRequest.new
    render :new
  end
  def create
    @cat_rental_request = CatRentalRequest.new(rental_params)

    if @cat_rental_request.save
      redirect_to cat_url(@cat_rental_request.cat)
    else
      render :new
    end
  end

  def edit
    @cat_rental_request = CatRentalRequest.find_by(id: params[:id])
    render :edit
  end
  def update
    @cat_rental_request = CatRentalRequest.find_by(id: params[:id])

    if @cat_rental_request.update_attributes(rental_params)
      redirect_to cat_url(@cat_rental_request.cat)
    else
      render :edit
    end
  end


  def approve
    @request = CatRentalRequest.find_by(id: params[:id])
    @request.approve!
    redirect_to cat_url(@request.cat_id)
  end
  def deny
    @request = CatRentalRequest.find_by(id: params[:id])
    @request.deny!
    redirect_to cat_url(@request.cat_id)
  end

  private 
  
  def rental_params
    params.require(:cat_rental_request)
      .permit(:cat_id, :start_date, :end_date, :status)
  end

end