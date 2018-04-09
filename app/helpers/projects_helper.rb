module ProjectsHelper

  def set_as_main_project
    Project.where('id != ? and main_project', params[:id]).update_all("main_project = 'false'")
  end

  def set_as_contact_page_project
    Project.where('id != ? and contact_page_project', params[:id]).update_all("contact_page_project = 'false'")
  end
end