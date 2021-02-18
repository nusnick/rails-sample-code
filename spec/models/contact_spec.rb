require 'spec_helper'

describe Contact do

  context "Associations" do
    it {should belong_to(:user)}
  end

end
