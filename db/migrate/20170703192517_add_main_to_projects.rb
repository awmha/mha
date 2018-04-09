class AddMainToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :main_project, :boolean
  end
end
