class RemoveMainProjectAndContactPageProjectAndDisplayFromProjects < ActiveRecord::Migration[5.0]
  def change
    remove_column :projects, :main_project, :boolean
    remove_column :projects, :contact_page_project, :boolean
    remove_column :projects, :display, :boolean
  end
end
