require 'spec_helper'

describe SolutionSpecialization do

  context "Associations" do
    it {should belong_to(:author)}
  end

  context "Validations" do
    it {should validate_presence_of(:title)}
  end

end
