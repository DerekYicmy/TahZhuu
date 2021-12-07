class Api::V1::CoursesController < ApplicationController
  #skip_before_action: verify_authenticity_token
  before_action :check_login

  def like
    course = Course.find(params[:id])
    favorite_course = FavorCourse.find_by(user: current_user, course: course)
    if favorite_course
      favorite_course.destroy
      render json: {status: 'unlike'}
    else
      current_user.favorite_courses<< course 
      render json: {status: 'like'}
    end
    
  end

  private

  def check_login
    if not user_signed_in?
      render json: { status: "failed", message: " Must sign in" },
      stauts: 401
    return #early return
    end
  end
end


