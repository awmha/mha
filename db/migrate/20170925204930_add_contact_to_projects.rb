class AddContactToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :contact_page_project, :boolean
  end
end