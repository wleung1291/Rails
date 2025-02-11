class CatRentalRequestsController < ApplicationController
  before_action :require_current_user!, only: %i(approve deny)
  before_action :require_cat_ownership!, only: %i(approve deny)
  
  def approve
    current_cat_rental_request.approve!
    redirect_to cat_url(current_cat)
  end

  def create
    # @rental_request = CatRentalRequest.new(cat_rental_request_params)
    # @rental_request.user_id = current_user.id
    # or 
    @rental_request = current_user.requests.new(cat_rental_request_params)
    
    if @rental_request.save
      redirect_to cat_url(@rental_request.cat)
    else
      flash.now[:errors] = @rental_request.errors.full_messages
      render :new
    end
  end

  def deny
    current_cat_rental_request.deny!
    redirect_to cat_url(current_cat)
  end

  def new
    @rental_request = CatRentalRequest.new(cat_id: params[:cat_id])
  end

  private

  # only allow the owner of the cat to approve or deny rental requests
  def require_cat_ownership!
    return if current_user.id == current_cat.user_id
    redirect_to cat_url(current_cat)
  end

  def current_cat_rental_request
    @rental_request ||=
      CatRentalRequest.includes(:cat).find(params[:id])
  end

  def current_cat
    current_cat_rental_request.cat
  end

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :end_date, :start_date, :status)
  end
end
