class AddOrderToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :order, :integer
  end
end
