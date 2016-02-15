class SessionsController < ApplicationController

  def new
    @session = User.new
  end


  def create
    user = User.find_by_email(params[:user][:email])
    puts "MY CODE IS ABOVE THIS LINE"
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to "/users/#{user.id}"
    else
      flash[:errors] = "Invalid"
      redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/sessions/new'
  end
end
