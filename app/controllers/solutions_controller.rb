class SolutionsController < BaseController

  #GET /solutions
  #getting all solutions in the system
  def index
    page = params[:page] || 1
    per_page = params[:per_page] || PER_PAGE
    @sort_column = sort_column
    @direction = sort_direction

    if params[:spec_id]
      if params[:spec_id].to_i == 0
        @spec = SolutionSpecialization.new({:id => 0, "title" => t("solution_specs.default_title")})
      else
        @spec = SolutionSpecialization.find(params[:spec_id])
      end
    end

    @solutions = Solution.scoped

    if @sort_column == "author"
      sort_col = "users.full_name #{@direction}, users.email"
    else
      sort_col = @sort_column
    end

    if params[:spec_id] && params[:spec_id].to_i != 0
      @solutions = @solutions.joins(:specializations).where("solution_specializations.id" => params[:spec_id])
    end

    @solutions = @solutions.joins("LEFT JOIN users ON solutions.author_id = users.id")
      .paginate(:page => page, :per_page => per_page, :select => "solutions.*")
      .order("#{sort_col} #{@direction}")
  end

  #PUT /solutions/:id/toggle_status
  #Change status of solution
  def toggle_status
    @solution.toggle_status
    action = @solution.published? ? "published" : "unpublished"
    redirect_to solutions_path, :notice => t("solutions.#{action}_successfully")
  end

  #DELETE /solutions/:id
  def destroy
    @solution.destroy
    redirect_to solutions_path, :notice => t("solutions.deleted_successfully")
  end

  #GET /solutions/new
  def new
    @solution = Solution.new
    @solution.published = true
  end

  #POST /solutions
  def create
    @solution = Solution.new(solution_params)
    if @solution.save
      redirect_to solutions_path, :notice => t("solutions.created_successfully")
    else
      @solution.image = nil
      render :new
    end
  end

  #GET /solutions/:id/edit
  def edit
  end

  #PUT /solutions/:id
  def update
    if @solution.update_attributes(solution_params)
      redirect_to solution_path(@solution), :notice => t("solutions.updated_successfully")
    else
      render :edit
    end
  end

  #GET /solutions/:id
  def show
  end

  #Search users to assign as authors
  def search_authors
    @users = User.search(params[:q])
    render :json => @users
  end

  private
  def solution_params
    params.require(:solution).permit(:title, :teaser, :favor, :full_text,
      :published, :image, :author_id, :specialization_tokens, :tasks_attributes => [:title, :_destroy, :id])
  end

  def sort_column
    Solution.sortable_column_names.include?(params[:sort_column].to_s) ? params[:sort_column] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
