class NotesController < ApplicationController

  def create
    @category = Category.find(params[:category_id])
    @system   = System.find(params[:system_id])
    @image    = Image.find(params[:image_id])
    @note     = @image.notes.create(note_params)

    redirect_to edit_category_system_image_path(@category, @system, @image)
  end

  def edit
    @note     = Note.find(params[:id])
  end

  def update
    @category = Category.find(params[:category_id])
    @system   = System.find(params[:system_id])
    @image    = Image.find(params[:image_id])
    @note     = Note.find(params[:id])

    @note.update
    redirect_to edit_category_system_image_path(@category, @system, @image)
  end

  private
    def note_params
      params.require(:note).permit(:information)
    end
end
