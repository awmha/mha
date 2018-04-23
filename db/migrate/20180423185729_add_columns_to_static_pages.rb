class AddColumnsToStaticPages < ActiveRecord::Migration[5.0]
  def change
    add_column :static_pages, :meta_description, :text
    add_column :static_pages, :meta_keywords, :text
  end
end
