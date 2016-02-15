class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
    @user = User.find(params[:id])
    @secret = Secret.new
    @secrets = @user.secrets.all
    likes = Like.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      flash[:answer] = "Profile updated"
      redirect_to @user
    else
      flash[:answer] = "Could not update"
      redirect_to :back
    end
  end

  def destroy
    @user = current_user
    @user.destroy
    reset_session
    redirect_to sessions_new_path
  end


  private
    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end

    # def update_params
    #   params.require(:user).permit(:email, :name)
    # end
end
