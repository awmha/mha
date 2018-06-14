class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user
  include ProjectsHelper

  def index
    @projects = Project.all

    if @projects.where(category: "main").count > 1
      flash[:warning] = "There is more than one project set as MAIN. Only the first project listed will be displayed as the main carousel."
    end
  end

  def show
  end

  def new
    @project = Project.new
    @project_pictures = @project.project_pictures.build
  end

  def edit
    @project = Project.find(params[:id])
    @project.pictures.build if @project.pictures.empty?
  end

  def create
    @project = current_user.projects.build(project_params)

    if @project.save
      if params[:images]
        params[:images].each { |image|
          @project.pictures.create(image: image)
        }
        @project.add_initial_position
        @project.save
      end
      flash[:success] = "Your project has been created."
      redirect_to @project
    else 
      flash[:danger] = "Something went wrong."
      render :new
    end
  end

  def update
    @project = Project.find(params[:id])
    if params[:project][:category] != @project.category
      @project.add_initial_position
    end
    if params[:project][:category] == "main"
      #if another project is already MAIN, sets to no_display
      set_as_main_project
    end
    if params[:project][:category] == "contact"
      set_as_contact_page_project
    end
    if Project.all.where(category: "main").count == 1 && @project.category == "main" && params[:project][:category] != "main"
      flash[:danger] = "Cannot change category from MAIN. First set a different project as MAIN and then change the category of the former MAIN project."
      redirect_to projects_url and return
    end
    if Project.all.where(category: "contact").count == 1 && @project.category == "contact" && params[:project][:category] != "contact"
      flash[:danger] = "Cannot change category from CONTACT. First set a different project as CONTACT and then change the category of the former CONTACT project."
      redirect_to projects_url and return
    end

    if @project.update_attributes(project_params)
      if params[:images]
        params[:images].each { |image|
          @project.pictures.create(image: image)
        }
        if @project.project_pictures.maximum("position").nil?
          @project.add_initial_position
        else
          @project.add_new_position
        end
      end
      @project.save
      flash[:success] = "Project has been updated."
      redirect_to @project
    else
      render :edit
    end
  end

  def destroy
    set_project
    if @project.destroy
      flash[:success] = "Project has been deleted."
      redirect_to projects_url
    else
      flash[:danger] = "Couldn't delete the project."
      redirect_to(:back)
    end
  end

  def move_image_up
    @project = Project.find(params[:project])
    old_position = params[:image_position].to_i
    if old_position == 1
      flash[:danger] = "Image is already first.  Can't move it up."
      redirect_to edit_project_path
    else
      new_position = old_position - 1
    end

    original_higher_image = @project.project_pictures.find_by(position: new_position)
    original_higher_image.position = old_position

    new_higher_image = @project.project_pictures.find_by(position: old_position)
    new_higher_image.position = new_position

    # @project.project_pictures.insert(new_position, @project.project_pictures.delete_at(old_position))
    new_higher_image.save
    original_higher_image.save
    # @project.update_attributes({pictures: @project.project_pictures})
    flash[:success] = "Image has been moved up."
    redirect_to edit_project_path
    # end
  end

  def move_image_down
    @project = Project.find(params[:project])
    old_position = params[:image_position].to_i
    if old_position == @project.project_pictures.count
      flash[:danger] = "Image is already last. Can't move it down."
      redirect_to edit_project_path
    elsif old_position == 0

      #move this to model
      height = @project.project_pictures.find_by(position: 1).picture.height.to_f.round(2)
      width = @project.project_pictures.find_by(position: 1).picture.width.to_f.round(2)

      ratio = width/height

      if ratio.round(2) != 1.56
        flash[:danger] = "You cannot move this picture down as the image below cannot be made a thumbnail as the ratio between width and height must be 1.56"
        redirect_to edit_project_path and return
      else
        new_position = old_position + 1
      end
    else
      new_position = old_position + 1
    end

    original_lower_image = @project.project_pictures.find_by(position: new_position)
    original_lower_image.position = old_position

    new_lower_image = @project.project_pictures.find_by(position: old_position)
    new_lower_image.position = new_position

    new_lower_image.save
    original_lower_image.save
    flash[:success] = "Image has been moved down."
    redirect_to edit_project_path
  end

  def make_thumbnail
    @project = Project.find(params[:project])
    old_position = params[:image_position].to_i

    #move this to model
    width = params[:picture_width].to_f.round(2)
    height = params[:picture_height].to_f.round(2)
    ratio = width/height

    if ratio.round(2) != 1.56
      flash[:danger] = "Incorrect dimensions for thumbnail. Ratio between width and height must be 1.56"
      redirect_to edit_project_path
    elsif old_position == 0
      flash[:danger] = "Image is already set to thumbnail."
      redirect_to edit_project_path
    elsif @project.project_pictures.where(position: 0).present?
      original_thumb = @project.project_pictures.find_by(position: 0)
      new_thumb = @project.project_pictures.find_by(position: old_position)

      original_thumb.position = old_position
      new_thumb.position = 0
      original_thumb.save
      new_thumb.save

      flash[:success] = "Image is now set to thumbnail."
      redirect_to edit_project_path
    else
      new_position = 0
    
      original_image = @project.project_pictures.find_by(position: old_position)
      original_image.position = new_position
      original_image.save
      n = 1
      @project.project_pictures.where.not(position: 0).each do |project_picture|
        project_picture.position = n
        n += 1  
        project_picture.save      
      end

      flash[:success] = "Image is now set to thumbnail."
      redirect_to edit_project_path
    end
  end

  private
    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :location, :user_id, :category, project_pictures_attributes: [:id, picture_attributes: [:image, :position, :_destroy]])
    end

    def correct_user
      @project = current.user
    end
end
