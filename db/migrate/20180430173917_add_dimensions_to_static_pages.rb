class AddDimensionsToStaticPages < ActiveRecord::Migration[5.0]
  def change
    add_column :static_pages, :height, :integer
    add_column :static_pages, :width, :integer
  end
end