class AddFaviconToStaticPages < ActiveRecord::Migration[5.0]
  def change
    add_column :static_pages, :favicon, :string
  end
end
