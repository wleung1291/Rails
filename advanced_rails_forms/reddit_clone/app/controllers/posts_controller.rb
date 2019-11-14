class PostsController < ApplicationController
  before_action :require_user!, except: [:show]
  before_action :require_post_author, only: [:edit, :update]

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = current_user.posts.new(post_params)
    #@sub = current_post.sub
    #@post.sub_id = @sub.id
   
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    render :show
  end
  
  def edit
    @post = Post.find_by(id: params[:id])
    render :edit
  end
  
  def update
    @post = Post.find_by(id: params[:id])
    
    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    #redirect_to sub_url()
  end

  private

  def post_params
    # "sub_ids: []" accepts an array of sub_ids
    params.require(:post).permit(:title, :url, :content, :user_id, :sub_id, sub_ids: [])
  end

  def require_post_author
    return if current_user.posts.find_by(id: params[:id])
    render json: 'Forbidden', status: :forbidden
  end

end