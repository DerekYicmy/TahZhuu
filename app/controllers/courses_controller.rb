class CoursesController < ApplicationController
  
  before_action :set_course, only: [:edit, :update, :destroy]
  before_action :login?, except: [:index, :show]
  
   

  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end

  def create
    #@course = Course.new(course_params)
    #@course.user_id = current_user.id
    @course = current_user.courses.build(course_params)
    
    if @course.save
      redirect_to courses_path
    else
      render :new
    end
  end 

  def edit
  end 
  
  def show
    @course = Course.find(params[:id])
    @review = Review.new
    #@reviews = Review.where(course: @course)
    @reviews = @course.reviews.order [id: :desc] #getter #lazy loading
  end

  def update
    
    if @course.update(course_params)
      flash[:notice] = "Update Success!"
      redirect_to courses_path
    else
      render :edit
    end
  end

  def destroy
    
    @course.destroy
    flash[:notice] = "Delete Success!"
    redirect_to courses_path
  end

  private
  def set_course
    @course = current_user.courses.find(params[:id])
  end 
  
  def course_params
    params.require(:course).permit(:name, :price, :intro, :hour)
  end

  #def login? #authenticate!
  #  if user_signed_in?
  #    redirect_to sign_in_path, notice: "please login"
  #  end
  #end
end
  #def login?
  #  if session[:ursess] == nil
  #     redirect_to sign_in_path
  #  else
  #    render :index
  #  end
  #end
