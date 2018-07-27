class Project < ApplicationRecord
  belongs_to :user
  has_many :project_pictures, dependent: :destroy
  has_many :pictures, through: :project_pictures
  validates :name, :location, length: { maximum: 50 }
  validates :name, :user_id, presence: true
  # has_many :pictures, :inverse_of => :project, :dependent => :destroy
  accepts_nested_attributes_for :project_pictures, allow_destroy: true
  after_create :main_picture_default

  default_scope { order(order: :asc)}

  def self.with_pictures
    includes(:pictures)
  end

  def add_initial_position
    if self.category != "contact" && self.category != "main"
      n = -1
    else
      n = 0
    end

    self.pictures.sort_by(&:height).each do |project_picture|
      n += 1
      project_picture.project_pictures.first.update_attribute :position, n
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

  def check_order_by_category(cat)
    category_count = Project.where(category: cat).count

    max_order = Project.where(category: cat).maximum("order")

    if (max_order != category_count - 1) || (category_count != Project.where(category: cat).pluck(:order).uniq.length)
      n = 0
      Project.where(category: cat).each do |project|
        project.order = n
        n += 1
        project.save
      end
    end
  end
end