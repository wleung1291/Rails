class NotesController < ApplicationController
  before_action :require_user!

  def create
    @note = current_user.notes.new(note_params)

    if @note.save
      redirect_to track_url(@note.track_id)
    else
      flash.now[:errors] = @note.errors.full_messages
      redirect_to track_url(@note.track_id)
    end
  end

  def destroy
    @note = current_user.notes.find(params[:id])
    @note.destroy
    redirect_to track_url(@note.track_id)
  end

  private

  def note_params
    params.require(:note).permit(:comment, :track_id)
  end

end