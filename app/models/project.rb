class Project < ApplicationRecord
  belongs_to :user
  has_many :project_pictures, dependent: :destroy
  has_many :pictures, through: :project_pictures
  validates :name, :location, length: { maximum: 50 }
  validates :name, :user_id, presence: true
  # has_many :pictures, :inverse_of => :project, :dependent => :destroy
  accepts_nested_attributes_for :project_pictures, allow_destroy: true
  after_create :main_picture_default

  def self.with_pictures
    includes(:pictures)
  end

  def add_initial_position
    n = 1
    self.project_pictures.each do |project_picture|
      project_picture.position = n
      n += 1
    end
  end

  def add_new_position
    n = self.project_pictures.maximum("position")
    self.project_pictures.where(position: nil).each do |project_picture|
      n += 1
      project_picture.update_attribute :position, n
    end
  end

  def has_thumb?
    self.project_pictures.where(position: 0).any?
  end

  def main_picture_default
    self.category != "main"
    self.save
  end

  def project_category_list
    project_category_list = ["main", "contact", "residential", "no_display", "ecclesiastical"] << Project.all.pluck(:category)
    project_category_list.flatten.uniq
  end
end