class AddMainPictureToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :main_picture, :string
  end
end
