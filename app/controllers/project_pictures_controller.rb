class ProjectPicturesController < ApplicationController

  def destroy
    @project_picture = ProjectPicture.find_by(id: params[:id])
    # require 'pry'; binding.pry
    pictures_to_reposition = ProjectPicture.where(project_id: @project_picture.project_id).where("position > ?", @project_picture.position)
    n = @project_picture.position
    pictures_to_reposition.each do |project_picture|
      project_picture.position = n
      n += 1 
      project_picture.save
    end
    if @project_picture.destroy
      flash[:success] = "Picture has been removed from this project."
      redirect_to(:back)
    else
      flash[:error] = "Couldn't delete the project."
      redirect_to(:back)
    end
  end

  private

end