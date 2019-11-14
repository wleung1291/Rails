class CommentsController < ApplicationController

  def index    
    # GET localhost:3000/comments?user_id=10
    if params[:user_id]
      comments = Comment.where(user_id: params[:user_id])
    elsif params[:artwork_id]
      comments = Comment.where(artwork_id: params[:artwork_id])
    else
      comments = Comment.all
    end

    render json: comments
  end

  # POST /comments?comment[artwork_id]=5&comment[user_id]=10&comment[body]=test
  def create
    comment = Comment.new(comment_params)

    if comment.save
      render json: comment
    else
      render json: comment.errors.full_messages, status: :unprocessable_entitiy
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    render json: comment
  end


  # Like.create!(user_id: 10, likeable_id: 2, likeable_type: "Comment") or 
  # POST localhost:3000/comments/2/like?user_id=10
  # Example creates a like for the comment with id: 2 from user with id: 10
  def like
    like = Like.new(user_id: params[:user_id], 
      likeable_id: params[:id], likeable_type: 'Comment')
    
    if like.save
      render json: like
    else
      render json: like.errors.full_messages, status: :unprocessable_entity
    end
  end

  # POST localhost:3000/comments/2/unlike?user_id=10
  def unlike
    like = Like.find_by(user_id: params[:user_id], 
      likeable_id: params[:id], likeable_type: 'Comment')

    if like.destroy
      render json: like
    else
      render json: like.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :artwork_id, :body)
  end

end