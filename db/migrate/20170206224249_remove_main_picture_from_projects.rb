class RemoveMainPictureFromProjects < ActiveRecord::Migration[5.0]
  def change
    remove_column :projects, :main_picture, :string
  end
end
