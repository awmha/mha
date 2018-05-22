module ProjectsHelper

  def set_as_main_project
    Project.where("id != ? and category = 'main'", params[:id]).update_all("category = 'no_display'")
  end

  def set_as_contact_page_project
    Project.where("id != ? and category = 'contact'", params[:id]).update_all("category = 'no_display'")
  end
end