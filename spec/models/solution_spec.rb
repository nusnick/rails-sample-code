require 'spec_helper'

describe Solution do
  context "Associations" do
    it {should have_many(:tasks)}
    it {should belong_to(:author)}
    it {should have_and_belong_to_many(:specializations)}
  end

  context "Validations" do
    it {should validate_presence_of(:title)}
  end
end
