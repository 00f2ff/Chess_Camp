class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  # check authorization
  authorize_resource
  
  def index
    @activeStudents = Student.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    @inactiveStudents = Student.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def show
    @family = @student.family
    @upcomingCamps = @student.camps.active.upcoming.chronological
    @pastCamps = @student.camps.active.past.chronological
  end

  def new
    @student = Student.new
  end

  def edit
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to @student, notice: "#{@student.proper_name} was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    if @student.update(student_params)
      redirect_to @student, notice: "#{@student.proper_name} was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @student.destroy
    redirect_to students_url, notice: "#{@student.proper_name} was removed from the system."
  end

  private
    def set_student
      @student = Student.find(params[:id])
    end

    def student_params
      params.require(:student).permit(:first_name, :last_name, :family_id, :date_of_birth, :rating, :active)
    end
end
