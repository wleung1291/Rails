class ArtworkSharesController < ApplicationController

  #def index
  #  render json: ArtworkShare.all
  #end

  def create
    artwork_share = ArtworkShare.new(artwork_share_params)

    if artwork_share.save
      render json: artwork_share, status: :created
    else
      render json: artwork_share.errors.full_messages, status: :unprocessable_entity
    end
  end

  # This un-shares an Artwork with a User. To delete a share, the user should 
  # issue a DELETE to /artwork_shares/123, where 123 is the id of the 
  # ArtworkShare to destroy.
  def destroy
    artwork_share = ArtworkShare.find(params[:id])
    artwork_share.destroy
    render json: artwork_share
  end

  private

  def artwork_share_params
    params.require(:artwork_shares).permit(:artwork_id, :viewer_id)
  end
end