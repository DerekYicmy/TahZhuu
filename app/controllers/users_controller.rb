class UsersController < ApplicationController

  def sign_up
    @user = User.new
  end

  def account_verify
    clean_params = params.require(:user).permit(:username, :password, :email)

    @user = User.new(clean_params)

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

  def check
    u = User.login(params[:user])
    if u
      session[:ursess] = u.id
      redirect_to "/"
    else
      render html: "No User"
    end

  end
  #

end
