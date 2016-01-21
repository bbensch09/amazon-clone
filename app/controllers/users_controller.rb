class UsersController < ApplicationController
  before_action except: [:show] do
    redirect_to :root unless admin?
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    end
  end

  private

  def ensure_admin!
    unless current_user.admin?
      # sign_out current_user
      redirect_to root_path
      return false
    end
  end
  def user_params
   params.require(:user).permit(:email, :password, :admin)
 end

end
