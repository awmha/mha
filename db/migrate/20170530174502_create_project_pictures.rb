class CreateProjectPictures < ActiveRecord::Migration[5.0]
  def change
    create_table :project_pictures do |t|
      t.integer :project_id
      t.integer :picture_id
      t.integer :order

      t.timestamps
    end
  end
end
