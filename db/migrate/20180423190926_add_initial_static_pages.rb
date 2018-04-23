class AddInitialStaticPages < ActiveRecord::Migration[5.0]
  def up
    StaticPage.create(company_name: "Company Name, Inc.")
  end

  def down
    StaticPage.delete_all
  end
end