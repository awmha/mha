class RemoveOrderFromPictures < ActiveRecord::Migration[5.0]
  def change
    remove_column :pictures, :order, :integer
  end
end
