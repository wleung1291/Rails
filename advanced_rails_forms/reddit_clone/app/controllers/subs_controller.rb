class SubsController <ApplicationController
  before_action :require_user!, except: [:index, :show]
  before_action :require_sub_owner, only: [:edit, :update]

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = current_user.subs.new(sub_params) # sub creator is the moderator

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find_by(id: params[:id])
    render :show
  end

  def edit
    @sub = Sub.find_by(id: params[:id])
    render :edit
  end

  def update
    @sub = Sub.find_by(id: params[:id])

    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def destroy
    @sub = Sub.find_by(id: params[:id])
    @sub.destroy
    redirect_to subs_url
  end

  private
    # prohibit non-moderators from editing or updating the Sub
    def require_sub_owner
      return if current_user.subs.find_by(id: params[:id])
      render json: 'Forbidden', status: :forbidden
    end
    
    def sub_params
      params.require(:sub).permit(:title, :description)
    end
end