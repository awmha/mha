class Picture < ApplicationRecord
  # belongs_to :project, required: false
  has_many :project_pictures
  has_many :projects, through: :project_pictures
  # attr_accessor :image, :project_id, :description, :caption, :position
  # validates :project, :image, presence: true
  mount_uploader :image, PictureUploader

  # def image=(val)
  #   if !val.is_a?(String) && valid?
  #     image_will_change!
  #     super
  #   end
  # end
end