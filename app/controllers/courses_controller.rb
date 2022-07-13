class CoursesController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]
  before_action :set_course, only: %i[ show edit update destroy ]

  # GET /courses or /courses.json
  def index
    # if params[:title]
    #   @courses = Course.where('title ILIKE ?', "%#{params[:title]}%") #case-insensitive
    # else
    #   @q = Course.ransack(params[:q])
    #   @courses = @q.result.includes(:user)
    # end
    @ransack_courses = Course.ransack(params[:courses_search], search_key: :courses_search)
    @courses = @ransack_courses.result.includes(:user)
    
    @pagy, @courses = pagy(@ransack_courses.result.includes(:user))
  end
    

  # GET /courses/1 or /courses/1.json
  def show
    @lessons = @course.lessons
  end

  # GET /courses/new
  def new
    if current_user.has_role?(:admin ) || current_user.has_role?(:teacher )
      @course = Course.new
      authorize @course
    else
      redirect_to root_path, alert: "You don't have access"
    end
  end

  # GET /courses/1/edit
  def edit
    # authorize @course
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)
    # authorize @course
    @course.user = current_user

    respond_to do |format|
      if @course.save
        format.html { redirect_to course_url(@course), notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    authorize @course
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to course_url(@course), notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @course
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: "Course was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_course
      @course = Course.friendly.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:title, :description, :short_description, :price, :language, :level)
    end
end
