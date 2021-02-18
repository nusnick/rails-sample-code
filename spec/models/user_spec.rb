require 'spec_helper'

describe User do

  context "Associations" do
    it {should have_many(:solutions)}
    it {should have_many(:solution_specializations)}
    it {should have_one(:contact)}
  end

  context "Validations" do
    it {should validate_presence_of(:email)}
  end

  describe "Check user has been published or not" do
    before do
      User.destroy_all
      @user = FactoryGirl.create :user
    end

    it "return true" do
      @user.update_attributes(:published => 0)
      @user.toggle_status
      @user.published.should be_true
    end

    it "return false" do
      @user.toggle_status
      @user.published.should be_false
    end
  end

  describe "Check user is admin or not" do
    before do
      User.destroy_all
      @user = FactoryGirl.create :user
      Role.destroy_all
    end

      it "return true" do
        @user.update_attributes({:role_ids => [Role.create({"name" => "admin"}).id]})
        @user.is_admin?.should eq(true)
      end

      it "return true" do
        @user.update_attributes({:role_ids => [Role.create({"name" => "super_admin"}).id]})
        @user.is_admin?.should eq(true)
      end

      it "return false" do
        @user.update_attributes({:role_ids => [Role.create({"name" => "supervisor"}).id]})
        @user.is_admin?.should eq(false)
      end
  end


end
