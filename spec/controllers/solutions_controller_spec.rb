require 'spec_helper'

describe SolutionsController do
  before do
    Solution.destroy_all
    5.times do
      FactoryGirl.create(:solution)
    end
    @user = FactoryGirl.create(:user)
    @user.add_role(:super_admin)
    sign_in @user
  end
  describe "GET 'index'" do
    it "returns solutions" do
      get 'index'
      assigns(:solutions).should_not be_nil
      assigns(:solutions).length.should eq(5)
    end
  end

  describe "PUT toggle_status" do
    it "changes Solution from published to unpublished" do
      solution = FactoryGirl.create(:solution)
      solution.published = true
      solution.save

      put 'toggle_status', :id => solution.id
      solution.reload.published.should be_false
    end

    it "changes Solution from unpublished to published" do
      solution = FactoryGirl.create(:solution)
      solution.published = false
      solution.save

      put 'toggle_status', :id => solution.id
      solution.reload.published.should be_true
    end
  end

  describe "DELETE destroy" do
    it "deletes Solution from database" do
      solution = FactoryGirl.create(:solution)
      expect{
        delete 'destroy', :id => solution.id
      }.to change(Solution, :count).by(-1)
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
      @solution = FactoryGirl.create :solution
    end

    it "should render view" do
      get 'show', :id => @solution.id
      response.should be_success
    end
  end

  describe "GET edit" do
    before do
      @solution = FactoryGirl.create :solution
    end

    it "should render view" do
      get 'edit', :id => @solution.id
      response.should be_success
    end
  end

  describe "POST create" do
    context "with valid params" do
      before do
        @params = {
          :solution => {
            :title => "Test solution"
          }
        }
      end
      it "creates new solution" do
        expect {
          post :create, @params
        }.to change(Solution, :count).by(1)
      end

      it "redirects to solution list page" do
        post :create, @params
        response.should redirect_to solutions_path
      end

      it "creates new tasks" do
        @params[:solution][:tasks_attributes] = {
          "0" => {:title => "Task 1"},
          "1" => {:title => "Task 2"}
        }
        expect {
          post :create, @params
        }.to change(Task, :count).by(2)
      end
    end

    context "with invalid params" do
      before do
        @params = {:solution => {:title => ""}}
      end
      it "does not create new solution in db" do
        expect{
          post :create, @params
        }.to change(Solution, :count).by(0)
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
        @solution = FactoryGirl.create :solution
        @params = {
          :solution => {
            :title => "Test solution"
          }
        }
      end

      it "update solution" do
        put :update, :id => @solution.id, :solution => @params[:solution]
        @solution.reload.title.should eq("Test solution")
        response.should redirect_to solution_path(@solution)
      end
    end

    context "with invalid data" do
      before do
        @solution = FactoryGirl.create :solution
        @params = {
          :solution => {
            :title => "Test solution"
          }
        }
      end

      it "should not update solution" do
        @params[:solution][:title] = ""
        put :update, :id => @solution.id, :solution => @params[:solution]
        response.should render_template :edit
      end
    end
  end

end
