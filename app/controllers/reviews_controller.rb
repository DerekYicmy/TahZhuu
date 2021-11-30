class ReviewsController < ApplicationController
  before_action :login?
  def create
    course = Course.find(params[:course_id])
    review = course.reviews.build(review_params)
    #review.user = current_user
    #review.user_id = current_user.id
    if review.save
      redirect_to course_path(course), notice: "Review Posted!"
    else

    end
  end
  private 
  def review_params
    params.require(:review).permit(:title, :content, :rating).merge(user: current_user)
  end
end
