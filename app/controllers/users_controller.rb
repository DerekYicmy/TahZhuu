class UsersController < ApplicationController

  def sign_up
    @user = User.new
  end

  def account_verify
    
    @user = User.new(user_params)

    if @user.save
      redirect_to "/"
    else
      #redirect_to '/sign_up'
      render :sign_up #borrow sign_up view 
    end
  end

  def sign_in
    @user = User.new
  end

  def sign_out
    session[:ursess] = nil
    redirect_to courses_path, notice: '已登出'
  end

  def check
    u = User.login(params[:user])
    if u
      session[:ursess] = u.id
      redirect_to "/"
    else
      render html: "No User"
    end
  end
  private
  def user_params
    params.require(:user).permit(:username, :password, :email)
  end


end