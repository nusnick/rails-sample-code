class Solution < ActiveRecord::Base

  ### VALIDATIONS ###
  validates_presence_of :title
  validate :image_is_less_than_two_megabytes
  validates_length_of :title, :maximum => 255
  validates_length_of :favor, :maximum => 255, :allow_blank => true
  validates_length_of [:teaser, :full_text], :maximum => 5000, :allow_blank => true

  ### ASSOCIATIONS ###
  belongs_to :author, :class_name => :User
  has_many :tasks, :dependent => :destroy
  has_and_belongs_to_many :specializations, :class_name => :SolutionSpecialization, :join_table => "solutions_specs", :association_foreign_key => "spec_id"

  has_attached_file :image, :styles => {:thumb => "100x100#", :large => "600x600>"},
    default_url: "solution_default.png"
  validates_attachment_content_type :image, :content_type => ["image/jpeg", "image/png",
    "image/gif", "image/bmp", "image/jpg"]

  attr_reader :specialization_tokens

  accepts_nested_attributes_for :tasks, :reject_if => lambda{|t| t[:title].blank? }, :allow_destroy => true

  ### FUNCTIONS ###

  #Change status of this solution from published to unpublished vice versa
  def toggle_status
    self.published = !published
    self.save
  end

  def specialization_tokens=(ids)
    self.specialization_ids = ids.split(",")
  end

  def self.sortable_column_names
    %w[title author published favor created_at updated_at]
  end

  private
  def image_is_less_than_two_megabytes
    if self.image?
      if self.image.size > 2.megabytes
        errors.add(:image, I18n.t("solutions.image_file_size_validation"))
      end
    end
  end
end
