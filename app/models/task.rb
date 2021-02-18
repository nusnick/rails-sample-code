class Task < ActiveRecord::Base

  ### VALIDATIONS ###
  validates_presence_of :title
  validates_length_of :title, :maximum => 255

  ### ASSOCIATIONS ###
  belongs_to :solution

end
