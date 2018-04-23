class CreateStaticPages < ActiveRecord::Migration[5.0]
  def change
    create_table :static_pages do |t|
      t.string :company_name
      t.text :about_us
      t.string :address_line_1
      t.string :address_line_2
      t.string :phone_number
      t.string :fax_number
      t.string :company_email
      t.text :social_media
      t.text :contact_text
    end
  end
end
