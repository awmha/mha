class AddLogoToStaticPages < ActiveRecord::Migration[5.0]
  def change
    add_column :static_pages, :logo, :string
  end
end
