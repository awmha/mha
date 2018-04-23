class PicturesController < ApplicationController
  before_action :logged_in_user
  
  def index
    @pictures = Picture.all
  end

  def create
    @picture = Picture.new(picture_params)
    @picture.save
    redirect_to(:back)
  end

  def destroy
    set_picture
    if @picture.destroy
      flash[:success] = "Picture has been deleted."
      redirect_to :back
    else
      flash[:error] = "Couldn't delete the picture."
      redirect_to(:back)
    end
  end

  private
    def set_picture
      @picture = Picture.find(params[:id])
    end

    def picture_params
      params.require(:picture).permit(:images, :project_id, :image, :description, :caption, :position)
    end
end
