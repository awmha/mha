module StaticPagesHelper
  def main_project
    main_project = @projects.find_by(category: "main")

    if main_project.nil?
      return @projects.first
    end

    main_project
  end

  def contact_project
    @projects.find_by(category: "contact")
  end

  def projects_for_carousel
    no_display = ["no_display", "contact", "main"]
    @projects.where.not(category: no_display)
  end

  def get_thumbnail(project)
    if project.project_pictures.find_by(position: 0).nil?
      return project.project_pictures.first.picture.image
    else
      return project.project_pictures.find_by(position: 0).picture.image
    end
  end

  def gallery_images(project)
    project.project_pictures.where.not(position: 0)
  end
end