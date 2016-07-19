class UserSessionsController < ApplicationController

  def new
    if session[:user_id]
      redirect_to root_path
    end
  end

  def create
    @user = User.find_by(username: params[:login_info][:username])
    if @user
      if @user.authenticate(params[:login_info][:password])
        session[:user_id] = @user.id
        redirect_to :root
      else
        render :new
      end
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end



end
