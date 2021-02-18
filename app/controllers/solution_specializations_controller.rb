class SolutionSpecializationsController < BaseController
  #GET /solution_specializations
  #getting all solutions in the system
  def index
    page = params[:page] || 1
    per_page = params[:per_page] || PER_PAGE
    @sort_column = sort_column
    @direction = sort_direction
    params[:q] = params[:q] || ''
    params[:type] = params[:type] || 'all'

    if @sort_column == "author"
      sort_col = "users.full_name #{@direction}, users.email"
    else
      sort_col = @sort_column
    end

    @solution_specs = SolutionSpecialization.search(params[:q], params[:type])
      .joins("LEFT JOIN users on author_id = users.id")
      .paginate(:page => page, :per_page => per_page)
      .order("#{sort_col} #{@direction}")

    respond_to do |format|
      format.html{}
      format.json do
        @solution_specs = [SolutionSpecialization.new({:id => 0,
          "title" => t("solution_specs.default_title")})].concat(@solution_specs) if params[:add_more]
        render :json => @solution_specs
      end
    end
  end

  #PUT /solution_specializations/:id/toggle_status
  #Change status of solution
  def toggle_status
    if @solution_specialization.toggle_status
      action = @solution_specialization.published? ? "published" : "unpublished"
      redirect_to solution_specializations_path, :notice => t("solution_specs.#{action}_successfully")
    else
      redirect_to solution_specializations_path, :alert => t("solution_specs.cannot_unpublished")
    end
  end

  #DELETE /solution_specializations/:id
  def destroy
    if @solution_specialization.destroy
      redirect_to solution_specializations_path, :notice => t("solution_specs.deleted_successfully")
    else
      redirect_to solution_specializations_path, :alert => t("solution_specs.cannot_delete")
    end
  end

  #GET /solution_specializations/new
  def new
    @solution_specialization = SolutionSpecialization.new
    @solution_specialization.published = true
  end

  #POST /solution_specializations
  def create
    params[:solution_specialization][:author_id] = current_user.id
    @solution_specialization = SolutionSpecialization.new(solution_spec_params)
    if @solution_specialization.save
      redirect_to solution_specializations_path, :notice => t("solution_specs.created_successfully")
    else
      render :new
    end
  end

  #GET /solution_specializations/:id/edit
  def edit
  end

  #PUT /solution_specializations/:id
  def update
    if @solution_specialization.update_attributes(solution_spec_params)
      redirect_to solution_specialization_path(@solution_specialization),
        :notice => t("solution_specs.updated_successfully")
    else
      render :edit
    end
  end

  #GET /solution_specializations/:id
  def show
  end

private
  def solution_spec_params
    params.require(:solution_specialization).permit(:title,
      :published, :author_id)
  end

  def sort_column
    SolutionSpecialization.sortable_column_names.include?(params[:sort_column]) ?
      params[:sort_column] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
