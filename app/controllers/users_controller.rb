class UsersController < BaseController

  ##
  #Handle index request get list of user
  def index
    page = params[:page] || 1
    per_page = params[:per_page] || PER_PAGE

    @users = @users.where.not(id: current_user.id).paginate(page: page, per_page: per_page).order("email, full_name")
  end

  ##
  #Handle show user details by administrator
  def show
    @roles = Role.all
    @user.build_contact if @user.contact.nil?
  end

  ##
  #Handle new user by administrator
  def new
    @user = User.new
    @user.build_contact
    @roles = Role.accessible_roles
  end

  ##
  #Handle edit user by administrator
  def edit
    @user.build_contact unless @user.contact
    @roles = Role.accessible_roles
    @user.role = @user.role_ids[0]
  end

  ##
  #Handle update user by administrator
  #Return::
  #
  def update
    if @user.update_attributes(user_params)
      if params[:id].to_i == current_user.id
        flash[:notice] = t("users.update_profile_successfully")
        redirect_to user_path(current_user)
      else
        flash[:notice] = t("users.update_user_successfully")
        redirect_to users_path
      end
    else
      @roles = Role.accessible_roles
      @user.role = @user.role_ids[0]
      render :edit
    end
  end

  ##
  #Handle create user by administrator
  def create
    @user = User.invite_user user_params
    if @user.save
      flash[:notice] = t('users.created_successfully')
      redirect_to users_path
    else
      @roles = Role.accessible_roles
      @user.role = @user.role_ids[0]
      render :new
    end
  end

  ##
  #Handle destroy request destroy a user
  def destroy
    @page = params[:page] || 1
    if @user.destroy
      redirect_to(users_url(:page => @page), :notice => t("users.deleted_successfully"))
    else
      redirect_to(users_url(:page => @page), :alert => t("users.cannot_delete_user"))
    end
  end

  ##
  #Handle publish or unpublish a user
  def toggle_status
    desired_status = @user.published? ? User::STATUS[:unpublished] : User::STATUS[:published]
    @page = params[:page] || 1
    if @user.toggle_status
      redirect_to(users_url(:page => @page), :notice => t("users.#{desired_status}_successfully"))
    else
      redirect_to(users_url(:page => @page), :alert => t("users.cannot_#{desired_status}"))
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :role, {:role_ids => []}, :password, :password_confirmation,
      :remember_me, :full_name, :karma, :services, :about, :additional_info,
      :published, :email, :avatar, contact_attributes:[:id, :city, :country, :phone,
        :address, :skype, :facebook_link, :vkontakte_link, :twitter_link,
        :linkedin_link, :website_link])
  end

end
