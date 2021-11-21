class CoursesController < ApplicationController
  def index
  end

  def new
    @course = Course.new
  end

  def create
    redirect_to courses_path
  end 
    

  

end
