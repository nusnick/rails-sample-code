require 'spec_helper'

describe UsersController do
  before do
    User.destroy_all
    @admin = FactoryGirl.create(:user)
    @admin.add_role(:super_admin)
    sign_in @admin
  end
  describe "PUT toggle_status" do
    before do
      @user = FactoryGirl.create :user
    end
    context "User is published" do
      it "should unpublish user" do
        @user.update_attributes({"published" => "1"})
        put :toggle_status, :id => @user.id
        @user.reload
        @page = assigns(:page)
        response.should redirect_to users_path(:page => @page)
        @user.published.should be_false
      end
    end
    context "User is unpublished" do
      it "should publish user" do
        @user.update_attributes({"published" => "0"})
        put :toggle_status, :id => @user.id
        @user.reload
        @page = assigns(:page)
        response.should redirect_to users_path(:page => @page)
        @user.published.should be_true
      end
    end
  end

  describe "DELETE destroy" do
    before do
      @user = FactoryGirl.create :user
    end
    it "should destroy user" do
      expect{
        delete :destroy, :id => @user.id
      }.to change(User, :count).by(-1)
      @page = assigns(:page)
      response.should redirect_to users_path(:page => @page)
    end

    it "should not destroy SUPERADMIN" do
      @user.add_role(:super_admin)
      expect{
        delete :destroy, :id => @user.id
      }.to change(User, :count).by(0)
      @page = assigns(:page)
      response.should redirect_to users_path(:page => @page)
    end

    it "should not destroy user has solution" do
      solution = FactoryGirl.create :solution
      @user.solutions << solution
      expect{
        delete :destroy, :id => @user.id
      }.to change(User, :count).by(0)
      @page = assigns(:page)
      response.should redirect_to users_path(:page => @page)
    end

    it "should not destroy user has solution specialization" do
      solution = FactoryGirl.create :solution_specialization
      @user.solution_specializations << solution
      expect{
        delete :destroy, :id => @user.id
      }.to change(User, :count).by(0)
      @page = assigns(:page)
      response.should redirect_to users_path(:page => @page)
    end
  end

  describe "GET new" do
    it "should render view" do
      get :new
      response.should be_success
    end
  end

  describe "POST create" do
    before do
      @user = FactoryGirl.create :user
      @user_params = {:email => @user.email, :role => Role.create({:name => "super_admin"}).id, :password => '12345678', :password_confirmation => '12345678'}
    end

    it "should create user" do
      valid_email = @user.email + 'clone'
      @user_params[:email] = valid_email
      expect{
        post :create, :user => @user_params
      }.to change(User, :count).by(1)

      response.should redirect_to users_path
    end

    it "should not create user" do
      expect{
        post :create, :user => @user_params
      }.to change(User, :count).by(0)

      response.should render_template :new
    end

    it "should not create user when contact invalid" do
      @user_params[:contact_attributes] = {}
      @user_params[:contact_attributes][:phone] = '12345678901234567890'
       expect{
        post :create, :user => @user_params
      }.to change(User, :count).by(0)
      response.should render_template :new
    end
  end

  describe "GET index" do
    it "should render view" do
      FactoryGirl.create :user
      get :index
      response.should be_success
      assigns(:users).should_not be_nil
      assigns(:users).length.should eq(1)
    end
  end

  describe "GET edit" do
    before do
      @user = FactoryGirl.create :user
    end

    it "should render view" do
      get :edit, :id => @user.id
      response.should be_success
    end
  end

  describe "PUT update" do
    before do
      @user = FactoryGirl.create :user
      @user_params = {:karma => '1234'}
    end

    it "should update user" do
      put :update, :user => @user_params, :id => @user.id
      response.should redirect_to users_path
    end

    it "should not update user" do
      @user_params[:karma] = '123456'
      put :update, :user => @user_params, :id => @user.id
      response.should render_template :edit
    end

    it "should not update user when contact invalid" do
      @user_params[:contact_attributes] = {}
      @user_params[:contact_attributes][:phone] = '12345678901234567890'
      put :update, :user => @user_params, :id => @user.id
      response.should render_template :edit
    end
  end
end