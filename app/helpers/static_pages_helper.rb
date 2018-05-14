module StaticPagesHelper
  def main_project
    @projects.find_by(category: "main")
  end

  def contact_project
    @projects.find_by(category: "contact")
  end

  def projects_for_carousel
    @projects.where.not(category: "main").where.not(category: "contact")
  end
end