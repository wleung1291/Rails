class ArtworksController < ApplicationController

  def index 
    # render json: Artwork.all

    # The nested resource will still hit ArtworksController#index. Rewrite the 
    # index method to return: the Artworks owned by a user and 
    # the Artworks shared with the user.

    # can access the specified user through params[:user_id] because it is 
    # part of the nested route.
    render json: Artwork.artworks_for_user_id(params[:user_id])
  end

  def create
    artwork = Artwork.new(artwork_params)

    if artwork.save
      render json: artwork
    else
      render json: artwork.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    artwork = Artwork.find(params[:id])

    render json: artwork
  end

  def update
    artwork = Artwork.find(params[:id])

    if artwork.update_attributes(artwork_params)
      render json: artwork
    else 
      render json: artwork.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    artwork = Artwork.find(params[:id])
    artwork.drestroy
    render json: artwork
  end

  # POST localhost:3000/artworks/5/unlike?user_id=11
  def like
    like = Like.new(user_id: params[:user_id], 
      likeable_id: params[:id], likeable_type: 'Artwork')
    
    if like.save
      render json: like
    else
      render json: like.errors.full_messages, status: :unprocessable_entity
    end
  end

  # POST localhost:3000/artworks/5/unlike?user_id=11
  def unlike
    like = Like.find_by(user_id: params[:user_id], 
      likeable_id: params[:id], likeable_type: 'Artwork')

    if like.destroy
      render json: like
    else
      render json: like.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def artwork_params
    params.require(:artwork).permit(:title, :image_url, :artist_id)
  end

end