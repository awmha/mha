class ChangeOrderName < ActiveRecord::Migration[5.0]
  def change
    rename_column :project_pictures, :order, :position
  end
end
