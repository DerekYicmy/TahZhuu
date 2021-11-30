module UsersHelper
  def user_signed_in?
    session[:ursess].present?
  end

  def login? #authenticate!
    if !user_signed_in?
      redirect_to sign_in_path, notice: "please login"
    end
  end

  def current_user
    @current_user ||= User.find(session[:ursess])
    #User.find(session[:ursess])
    #find_by(id: session[:ursess])
  end
end
#find_by(id: course.id)
#find(:id)
#＠current_user ||= User.find_by(id: session[:ursess])