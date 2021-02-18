require 'spec_helper'

describe SolutionSpecializationsController do

  before do
    SolutionSpecialization.destroy_all
    5.times do
      FactoryGirl.create :solution_specialization
    end
    @user = FactoryGirl.create(:user)
    @user.add_role(:super_admin)
    sign_in @user
  end

  describe "GET index" do
    it "should return solution specializations" do
      get 'index'
      response.should be_success
      assigns(:solution_specs).should_not be_nil
      assigns(:solution_specs).length.should == 5
    end
  end

  describe "PUT toggle_status" do
    before do
      @solution_spec = FactoryGirl.create :solution_specialization
    end

    context "Solution specialization does not belong to solution" do
      it "should change solution specialization from published to unpublished" do
        put 'toggle_status', :id => @solution_spec.id
        @solution_spec.reload.published.should be_false
      end

      it "should change solution specialization from unpublished to published" do
        @solution_spec.update_attributes({"published" => false})
        put 'toggle_status', :id => @solution_spec.id
        @solution_spec.reload.published.should be_true
      end
    end

    context "Solution specialization belongs to solution" do
      it "should not change solution specialization from published to unpublished" do
        solution = FactoryGirl.create :solution
        @solution_spec.solutions << solution
        put 'toggle_status', :id => @solution_spec.id
        @solution_spec.reload.published.should be_true
      end
    end
  end

  describe "GET new" do
    it "should render view" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET show" do
    before do
      @solution = FactoryGirl.create :solution_specialization
    end

    it "should render view" do
      get 'show', :id => @solution.id
      response.should be_success
    end
  end

  describe "GET edit" do
    before do
      @solution = FactoryGirl.create :solution_specialization
    end

    it "should render view" do
      get 'edit', :id => @solution.id
      response.should be_success
    end
  end

  describe "DELETE destroy" do
    before do
      @solution_spec = FactoryGirl.create :solution_specialization
    end

    it "should delete solution specialization" do
      expect{
        delete :destroy, :id => @solution_spec.id
      }.to change(SolutionSpecialization, :count).by(-1)
    end

    it "should not delete solution specialization" do
      solution = FactoryGirl.create :solution
      @solution_spec.solutions << solution
      expect{
        delete :destroy, :id => @solution_spec.id
      }.to change(SolutionSpecialization, :count).by(0)
    end
  end

  describe "POST create" do
    context "with valid params" do
      before do
        @params = {
          :solution_specialization => {
            :title => "Test solution"
          }
        }
      end

      it "creates new solution" do
        expect {
          post :create, @params
        }.to change(SolutionSpecialization, :count).by(1)
      end

      it "redirects to solution list page" do
        post :create, @params
        response.should redirect_to solution_specializations_path
      end
    end

    context "with invalid params" do
      before do
        @params = {:solution_specialization => {:title => ""}}
      end
      it "does not create new solution in db" do
        expect{
          post :create, @params
        }.to change(SolutionSpecialization, :count).by(0)
      end

      it "stays at new solution page" do
        post :create, @params
        response.should be_success
      end
    end
  end

  describe "PUT update" do
    context "with valid params" do
      before do
        @solution = FactoryGirl.create :solution_specialization
        @params = {
          :solution_specialization => {
            :title => "Test solution"
          }
        }
      end

      it "update solution" do
        put :update, :id => @solution.id, :solution_specialization => @params[:solution_specialization]
        @solution.reload.title.should eq("Test solution")
        response.should redirect_to solution_specialization_path(@solution)
      end
    end

    context "with invalid data" do
      before do
        @solution = FactoryGirl.create :solution_specialization
        @params = {
          :solution_specialization => {
            :title => "Test solution"
          }
        }
      end

      it "should not update solution" do
        @params[:solution_specialization][:title] = ""
        put :update, :id => @solution.id, :solution_specialization => @params[:solution_specialization]
        response.should render_template :edit
      end
    end
  end

end
