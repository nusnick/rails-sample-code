require 'spec_helper'

describe Task do
  context "Associations" do
    it {should belong_to(:solution)}
  end
  context "Validations" do
    it {should validate_presence_of(:title)}
  end
end
