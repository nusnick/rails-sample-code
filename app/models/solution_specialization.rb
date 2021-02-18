class SolutionSpecialization < ActiveRecord::Base

  ### VALIDATIONS ####
  validates_presence_of :title
  validates_length_of :title, :maximum => 255

  before_destroy :can_destroy?
  before_save :can_unpublish?


  ### ASSOCIATIONS ###
  belongs_to :author, :class_name => :User
  has_and_belongs_to_many :solutions, :join_table => "solutions_specs", :foreign_key => "spec_id"


  scope :search, lambda { |keyword, type|
    where("LOWER(title) LIKE ? #{'and solution_specializations.published = TRUE' if type != 'all'}", "%#{keyword.downcase}%")
  }

  ### FUNCTIONS ###
  #Change status of this solution from published to unpublished vice versa
  def toggle_status
    if can_unpublish?
      self.published = !published
      self.save
    else
      return false
    end
  end

  def as_json(options)
    json = super(options)
    json[:name] = title
    json[:text] = title
    json
  end

  def self.sortable_column_names
    %w[title author created_at updated_at]
  end

  private
  def can_destroy?
    if self.solutions.length > 0
      errors.add(:base, I18n.t("solution_specs.cannot_delete"))
      return false
    else
      return true
    end
  end

  def can_unpublish?
    if !self.published && self.solutions.length > 0
      errors.add(:base, I18n.t("solution_specs.cannot_unpublished"))
      return false
    else
      return true
    end
  end
end
