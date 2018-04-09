class CreatePictures < ActiveRecord::Migration[5.0]
  def change
    create_table :pictures do |t|
      t.belongs_to :project, index: true
      t.string :image
      t.text :description
      t.text :caption
      t.integer :order
      t.timestamps
    end
  end
end
