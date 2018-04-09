class RemoveImagesFromProjects < ActiveRecord::Migration[5.0]
  def change
    remove_column :projects, :images, :string
  end
end
