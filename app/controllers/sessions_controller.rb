class SessionsController < ApplicationController # :nodoc:
  def login; end

  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url
    else
      @message = 'Username or password invalid'

      render 'login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, params: { msg: 'Successfully logged out' }
  end
end
