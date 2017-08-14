# UsersController to manage user requests
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    redirect_to 'new' # Hack to prevent the redirection when the form had errors and you reload it
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      redirect_to login_path
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    @successMessage = 'Successfully saved user' if @user.update(user_params)

    render 'profile'
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def profile
    @user = current_user
  end

  def mypictures; end
end
