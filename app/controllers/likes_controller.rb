class LikesController < ApplicationController
  def index
    @likes = Like.new
  end

  def create
    Like.create(user: current_user, secret: Secret.find(params[:secret_id]))
    redirect_to '/secrets'
  end

  def destroy
    @like = Like.where("user_id = ? AND secret_id = ?",session[:user_id],params['id'])
    @like[0].destroy
    redirect_to '/secrets'
  end
end
